import Realm from 'realm';

class User extends Realm.Object {}
User.schema = {
  name: 'User',
  properties: {
    id: 'string',
    username: 'string',
    profilePicture: 'string',
  },
  primaryKey: 'id',
};

class Message extends Realm.Object {}
Message.schema = {
  name: 'Message',
  properties: {
    id: 'string',
    text: 'string',
    timestamp: 'date',
    sender: 'User',
    isSentByUser: 'bool',
  },
  primaryKey: 'id',
};

class ChatSession extends Realm.Object {}
ChatSession.schema = {
  name: 'ChatSession',
  properties: {
    id: 'string',
    users: 'User[]',
    messages: 'Message[]',
    lastUpdated: 'date',
  },
  primaryKey: 'id',
};

export default new Realm({ schema: [User, Message, ChatSession] });

