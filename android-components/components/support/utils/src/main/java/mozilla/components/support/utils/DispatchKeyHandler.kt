package mozilla.components.support.utils

import android.view.KeyEvent

abstract class DispatchKeyHandler {
    abstract fun dispatchKeyEvent(event: KeyEvent): Boolean
}
