package mozilla.components.feature.shortcuts

import android.view.KeyEvent
import mozilla.components.feature.session.SessionUseCases
import mozilla.components.support.utils.DispatchKeyHandler

class ReloadHandler(_sessionUseCases: SessionUseCases) : DispatchKeyHandler() {
    val sessionUseCases = _sessionUseCases

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.getKeyCode() == KeyEvent.KEYCODE_REFRESH || (event.isCtrlPressed && event.getKeyCode() == KeyEvent.KEYCODE_R)) {
            sessionUseCases.reload()
            return true
        }
        return false
    }
}
