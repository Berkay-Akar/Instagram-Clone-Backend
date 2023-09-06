import { ApolloError } from "apollo-server";

export const messageResolver = {
  Query: {
    getConversations: async (_, __, { prisma, user }) => {
      const userId = user.id;
      try {
        console.log("top of the try");
        const conversations = await prisma.conversation.findMany({
          where: {
            OR: [{ userAId: userId }, { userBId: userId }],
          },
          include: {
            message: {
              select: {
                senderId: true,
                receiverId: true,
                content: true,
                created_at: true,
                updated_at: true,
                conversationId: true,
                id: true,
              },
            },
            userA: true,
            userB: true,
          },
        });
        console.log("top of transformed");

        if (!conversations) {
          throw new ApolloError(
            "Conversations not found",
            "CONVERSATIONS_NOT_FOUND"
          );
        }

        const transformedConversations = conversations.map((conversation) => ({
          ...conversation,
          userA: {
            id: conversation.userA.id,
            username: conversation.userA.username,
            name: conversation.userA.name,
            profile_photo: conversation.userA.profile_photo,
          },
          userB: {
            id: conversation.userB.id,
            username: conversation.userB.username,
            name: conversation.userB.name,
            profile_photo: conversation.userB.profile_photo,
          },
        }));

        console.log("Transformed Conversations:", transformedConversations);

        return transformedConversations;
      } catch (error) {
        console.error(error);
        throw new ApolloError(
          "Failed to retrieve conversations",
          "CONVERSATIONS_QUERY_ERROR",
          { originalError: error }
        );
      }
    },
  },

  Mutation: {
    sendMessage: async (_, { receiverId, content }, { prisma, user }) => {
      const senderId = user.id;
      try {
        // Check if the conversation between sender and receiver already exists

        const conversation = await prisma.conversation.findFirst({
          where: {
            OR: [
              { userAId: senderId, userBId: receiverId },
              { userAId: receiverId, userBId: senderId },
            ],
          },
        });
        console.log("conversation:", conversation);

        if (!conversation) {
          // If the conversation doesn't exist, create a new one
          const newConversation = await prisma.conversation.create({
            data: {
              userAId: senderId,
              userBId: receiverId,
            },
          });

          // Create the message associated with the new conversation
          const message = await prisma.message.create({
            data: {
              senderId,
              receiverId,
              content,
              conversationId: newConversation.id,
            },
          });

          return message;
        }

        // If the conversation already exists
        const message = await prisma.message.create({
          data: {
            senderId,
            receiverId,
            content,
            conversationId: conversation.id,
          },
        });

        return message;
      } catch (error) {
        console.error(error);
        throw new Error("Failed to send a message");
      }
    },
    getConversationMessage: async (_, { conversationId }, { prisma, user }) => {
      const userId = user.id;

      try {
        const messages = await prisma.message.findMany({
          where: {
            conversationId: conversationId,
          },
          orderBy: {
            created_at: "asc",
          },
        });
        console.log(messages);
        return messages;
      } catch (error) {
        console.log(error);
        throw new Error("Failed to get messages");
      }
    },
  },
};
