{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.IORef
import qualified Data.Text as Text
import GI.Gtk hiding (main)
import qualified GI.Gtk as Gtk

main :: IO ()
main = do
    Gtk.init Nothing

    ref <- newIORef 1

    window <- new Window []

    on window #destroy mainQuit

    box <- new Box [ #orientation := OrientationVertical ]

    #add window box

    n <- readIORef ref
    label <- new Label [ #label := Text.pack (show n) ]

    #add box label

    button <- new Button
                [
                    #label := "Click me!"
                ]

    #add box button

    on button #clicked $ do
        modifyIORef ref (+ 1)
        n2 <- readIORef ref
        #setText label (Text.pack (show n2))

    #showAll window

    Gtk.main
