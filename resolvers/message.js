import { ApolloError } from "apollo-server";

export const messageResolver = {
  Query: {
    getMessages: async (_, { conversationId }, { prisma, userId }) => {
      try {
        // Check if the user is a participant in the conversation
        const conversation = await prisma.conversation.findFirst({
          where: {
            id: conversationId,
            participants: { some: { id: userId } },
          },
          include: {
            messages: { include: { sender: true, receiver: true } },
          },
        });

        if (!conversation) {
          throw new ApolloError(
            "Conversation not found",
            "CONVERSATION_NOT_FOUND"
          );
        }

        return conversation.messages;
      } catch (error) {
        throw new ApolloError(
          "Failed to retrieve messages",
          "MESSAGES_QUERY_ERROR"
        );
      }
    },
  },

  Mutation: {
    // conversation id tut, varsa yeni oluşturma mesaj ekle, yoksa conversation id yoksa yeni bir conversation yarat
    sendMessage: async (
      _,
      { receiverId, content, conversationId },
      { prisma, user }
    ) => {
      console.log("sender", user.id);
      console.log("receiver", receiverId);
      try {
        const sender = await prisma.user.findFirst({ where: { id: user.id } });
        const receiver = await prisma.user.findFirst({
          where: { id: receiverId },
        });

        if (!sender || !receiver) {
          throw new ApolloError(
            "Invalid sender or receiver",
            "INVALID_SENDER_OR_RECEIVER"
          );
        }
        console.log("alkdhkaha");

        const message = await prisma.message.create({
          data: {
            receiverId: receiverId,
            userId: user.id,
            content,
            senderId: user.id,
            receiverId: receiverId,
          },
        });
        console.log("message", message);
        return message;
      } catch (error) {
        throw new ApolloError("Failed to send a message", "SEND_MESSAGE_ERROR");
      }
    },

    createConversation: async (_, { participantIds }, { prisma, user }) => {
      const userId = user.id;
      try {
        if (!participantIds.includes(userId)) {
          participantIds.push(userId);
        }

        const conversation = await prisma.conversation.create({
          data: {
            participants: { connect: participantIds.map((id) => ({ id })) },
          },
          include: { participants: true, messages: true },
        });

        return conversation;
      } catch (error) {
        throw new ApolloError(
          "Failed to create a conversation",
          "CREATE_CONVERSATION_ERROR"
        );
      }
    },
  },
};
