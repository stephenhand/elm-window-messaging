module CrossDocumentMessaging exposing (Site, postString, openSite, close)

import Result
import Maybe exposing (..)
import Native.CrossDocumentMessaging

type Site = Site
postString: Site -> String -> String -> Result String Bool

postString =
    Native.CrossDocumentMessaging.postMessage

openSite: String -> Maybe String -> Maybe String -> Site
openSite url name specs =
    openNativeSite url (name |> withDefault "") (specs |> withDefault "")

openNativeSite: String -> String -> String -> Site
openNativeSite =
    Native.CrossDocumentMessaging.open

close: Maybe Site -> ()
close site =
    case site of
        Nothing ->
            Native.CrossDocumentMessaging.close
        Just site ->
            Native.CrossDocumentMessaging.close site