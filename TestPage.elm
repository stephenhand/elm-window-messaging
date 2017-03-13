import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import List exposing (map, tail)
import CrossDocumentMessaging


main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


-- MODEL

type alias Model = { availableQueues: List String
 , filterText : String
 , breakOutSite : Maybe CrossDocumentMessaging.Site}



init : (Model, Cmd msg)
init =
  ({availableQueues = ["Queue 1", "Queue 2", "Queue 3"], filterText = "", breakOutSite = Nothing}, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg

subscriptions model =  Sub.none

-- UPDATE

type Msg = Increment | Decrement | FilterChange | BreakOut

update : Msg -> Model -> (Model, Cmd msg)
update msg model  =
    case msg of
        BreakOut
            ->
            (model, (case CrossDocumentMessaging.openSite "index.html" (Just "break_out") Nothing of _ -> Cmd.none))
        _
            ->
           (case msg of
             Increment ->
               {model | availableQueues = model.availableQueues ++ ["Another Queue"]}

             Decrement ->
               case (tail model.availableQueues) of
                 Nothing ->
                   {model | availableQueues = []}
                 Just clipped ->
                   {model | availableQueues = clipped}
             _ ->
               model
            , Cmd.none)



-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div []  (map (\queueName -> div [] [ text queueName ]) model.availableQueues)
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick BreakOut ] [ text "Break Out" ]
    ]