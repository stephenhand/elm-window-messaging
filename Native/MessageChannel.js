/**
 * Created by stephen.hand on 09/03/2017.
 */
var _stephenhand$window_messaging$MessageChannel = function(){
    function channel(){
        var nativeChannel = new MessageChannel();
        return {
            port1:port(nativeChannel.port1),
            port2:port(nativeChannel.port2)
        }
    }

    function port(nativePort){
        return {
            postMessage : function(message, objects){
                        
            },
            onMessage : function(){}
        }
    }

    return {
        channel : channel
    }
}();