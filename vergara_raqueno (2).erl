-module(vergara_raqueno).
-compile(export_all).

% initializes chat by asking for the name of the first user
% registers a process called connection which performs the connect_chat process
% with the entered name as its parameter
init_chat() ->                                                          
    Get_Name = io:get_line('Enter Your Name: '),
    Name = string:trim(Get_Name),

    register(connection, spawn(vergara_raqueno, connect_chat, [Name])).
  
% waits to receive message. if it receives the first node, it performs
% the next processes to send a message and show the conversation
connect_chat(Name) ->
    receive
        Node1 ->
            {connection1, Node1} ! {connected},
            register(connected_partner, spawn(vergara_raqueno, send_chat1, [Node1, Name])),
            register(firstconvo, spawn(vergara_raqueno, main_convo, []))
    end.

% sends a message with a format of --> You: <message>
send_chat1(Node1, Name) ->
    Message_line = io:get_line("You: "),
    Message = string:trim(Message_line),                        % uses trim function to return a string without enter key or \n
    if Message =:= "bye" ->                                     % if the message is 'bye', it will disconnect and end the process
        {secondconvo, Node1} ! bye,
            init:stop(0);
        true ->                                                 % otherwise, it continues to send another chat
            {secondconvo, Node1} ! {Message, Name},
            send_chat1(Node1, Name)
    end.

% shows the messages received and sent
main_convo() ->
    receive
        bye ->
            io:format("Your partner disconnected\n"),         % prompts once the process is disconnected
            init:stop(0);
        {Msg, Get_Name1} ->
            io:format("~s: ", [Get_Name1]),
            io:format("~s ~n", [Msg]),
            main_convo()
    end.

% initializes the process for the other shell and asks for the other user's name
init_chat2(Node2) ->
    Get_Name1 = io:get_line("Enter Your Name: "),
    Name1 = string:trim(Get_Name1),
    
    {connection, Node2} ! node(),
    register(connection1, spawn(vergara_raqueno, connect_chat1, [Node2, Name1])).

% once a connection is established, the other user is able to send a message and see the conversation
connect_chat1(Node2, Name1) ->
    receive
        {connected} ->
            register(connected_partner1, spawn(vergara_raqueno, send_chat2, [Node2, Name1])),
            register(secondconvo, spawn(vergara_raqueno, main_convo1, []))
    end.

% performs the same function with send_chat1, dedicated for the other node
send_chat2(Node2, Name1) ->
    Message_line1 = io:get_line("You: "),
    Message1 = string:trim(Message_line1),               
    if Message1 =:= "bye" ->
        {firstconvo, Node2} ! bye,
            init:stop(0);
        true ->
            {firstconvo, Node2} ! {Message1, Name1},
            send_chat2(Node2, Name1)
    end.

% shows the messages received and sent for the other node
main_convo1() ->
    receive
        bye ->
            io:format("Your partner disconnected\n"),         % prompts once the process is disconnected
            init:stop(0);
        {Msg, Get_Name} ->
            io:format("~s: ", [Get_Name]),
            io:format("~s ~n", [Msg]),
            main_convo1()
    end.