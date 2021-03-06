package org.bigbluebutton.lib.whiteboard.services {
	
	import org.bigbluebutton.lib.main.models.IConferenceParameters;
	import org.bigbluebutton.lib.main.models.IUserSession;
	import org.bigbluebutton.lib.whiteboard.models.IWhiteboardModel;
	
	public class WhiteboardService implements IWhiteboardService {
		
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var conferenceParameters:IConferenceParameters;
		
		[Inject]
		public var whiteboardModel:IWhiteboardModel;
		
		private var whiteboardMessageSender:WhiteboardMessageSender;
		
		private var whiteboardMessageReceiver:WhiteboardMessageReceiver;
		
		public function WhiteboardService() {
		}
		
		public function setupMessageSenderReceiver():void {
			whiteboardMessageSender = new WhiteboardMessageSender(userSession, conferenceParameters);
			whiteboardMessageReceiver = new WhiteboardMessageReceiver(whiteboardModel);
			userSession.mainConnection.addMessageListener(whiteboardMessageReceiver);
		}
		
		public function getAnnotationHistory(whiteboardId:String):void {
			whiteboardMessageSender.requestAnnotationHistory(whiteboardId);
		}
		
		public function undoGraphic():void {
			whiteboardMessageSender.undoGraphic()
		}
		
		public function clearBoard():void {
			whiteboardMessageSender.clearBoard();
		}
		
		public function sendShape():void {
			whiteboardMessageSender.sendShape();
		}
	}
}
