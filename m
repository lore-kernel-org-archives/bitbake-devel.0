Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E1171731E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 10:59:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 03:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723878759"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 03:59:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:04 +1200
Message-Id: <b0ee1990cdf061445700c0282f4c34e1539bb466.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 02/10] knotty: import latest python-progressbar
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 Jun 2016 10:59:52 -0000

Since we're going to make some minor extensions to it, it makes sense to
bring in the latest version of python-progressbar. Its structure has
changed a little but the API hasn't; however we do need to ensure our
overridden _needs_update() function's signature in BBProgress() matches
properly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py            |   2 +-
 lib/progressbar.py             | 384 -----------------------------------------
 lib/progressbar/LICENSE.txt    |  52 ++++++
 lib/progressbar/__init__.py    |  49 ++++++
 lib/progressbar/compat.py      |  44 +++++
 lib/progressbar/progressbar.py | 307 ++++++++++++++++++++++++++++++++
 lib/progressbar/widgets.py     | 355 +++++++++++++++++++++++++++++++++++++
 7 files changed, 808 insertions(+), 385 deletions(-)
 delete mode 100644 lib/progressbar.py
 create mode 100644 lib/progressbar/LICENSE.txt
 create mode 100644 lib/progressbar/__init__.py
 create mode 100644 lib/progressbar/compat.py
 create mode 100644 lib/progressbar/progressbar.py
 create mode 100644 lib/progressbar/widgets.py

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ddd36d5..6a6f688 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -51,7 +51,7 @@ class BBProgress(progressbar.ProgressBar):
             self._resize_default = None
         progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets, fd=sys.stdout)
 
-    def _handle_resize(self, signum, frame):
+    def _handle_resize(self, signum=None, frame=None):
         progressbar.ProgressBar._handle_resize(self, signum, frame)
         if self._resize_default:
             self._resize_default(signum, frame)
diff --git a/lib/progressbar.py b/lib/progressbar.py
deleted file mode 100644
index 114cdc1..0000000
--- a/lib/progressbar.py
+++ /dev/null
@@ -1,384 +0,0 @@
-#!/usr/bin/env python
-# -*- coding: iso-8859-1 -*-
-#
-# progressbar  - Text progressbar library for python.
-# Copyright (c) 2005 Nilton Volpato
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-
-"""Text progressbar library for python.
-
-This library provides a text mode progressbar. This is typically used
-to display the progress of a long running operation, providing a
-visual clue that processing is underway.
-
-The ProgressBar class manages the progress, and the format of the line
-is given by a number of widgets. A widget is an object that may
-display diferently depending on the state of the progress. There are
-three types of widget:
-- a string, which always shows itself;
-- a ProgressBarWidget, which may return a diferent value every time
-it's update method is called; and
-- a ProgressBarWidgetHFill, which is like ProgressBarWidget, except it
-expands to fill the remaining width of the line.
-
-The progressbar module is very easy to use, yet very powerful. And
-automatically supports features like auto-resizing when available.
-"""
-
-from __future__ import division
-
-__author__ = "Nilton Volpato"
-__author_email__ = "first-name dot last-name @ gmail.com"
-__date__ = "2006-05-07"
-__version__ = "2.3-dev"
-
-import sys, time, os
-from array import array
-try:
-    from fcntl import ioctl
-    import termios
-except ImportError:
-    pass
-import signal
-try:
-    basestring
-except NameError:
-    basestring = (str,)
-
-class ProgressBarWidget(object):
-    """This is an element of ProgressBar formatting.
-
-    The ProgressBar object will call it's update value when an update
-    is needed. It's size may change between call, but the results will
-    not be good if the size changes drastically and repeatedly.
-    """
-    def update(self, pbar):
-        """Returns the string representing the widget.
-
-        The parameter pbar is a reference to the calling ProgressBar,
-        where one can access attributes of the class for knowing how
-        the update must be made.
-
-        At least this function must be overriden."""
-        pass
-
-class ProgressBarWidgetHFill(object):
-    """This is a variable width element of ProgressBar formatting.
-
-    The ProgressBar object will call it's update value, informing the
-    width this object must the made. This is like TeX \\hfill, it will
-    expand to fill the line. You can use more than one in the same
-    line, and they will all have the same width, and together will
-    fill the line.
-    """
-    def update(self, pbar, width):
-        """Returns the string representing the widget.
-
-        The parameter pbar is a reference to the calling ProgressBar,
-        where one can access attributes of the class for knowing how
-        the update must be made. The parameter width is the total
-        horizontal width the widget must have.
-
-        At least this function must be overriden."""
-        pass
-
-
-class ETA(ProgressBarWidget):
-    "Widget for the Estimated Time of Arrival"
-    def format_time(self, seconds):
-        return time.strftime('%H:%M:%S', time.gmtime(seconds))
-    def update(self, pbar):
-        if pbar.currval == 0:
-            return 'ETA:  --:--:--'
-        elif pbar.finished:
-            return 'Time: %s' % self.format_time(pbar.seconds_elapsed)
-        else:
-            elapsed = pbar.seconds_elapsed
-            eta = elapsed * pbar.maxval / pbar.currval - elapsed
-            return 'ETA:  %s' % self.format_time(eta)
-
-class FileTransferSpeed(ProgressBarWidget):
-    "Widget for showing the transfer speed (useful for file transfers)."
-    def __init__(self, unit='B'):
-        self.unit = unit
-        self.fmt = '%6.2f %s'
-        self.prefixes = ['', 'K', 'M', 'G', 'T', 'P']
-    def update(self, pbar):
-        if pbar.seconds_elapsed < 2e-6:#== 0:
-            bps = 0.0
-        else:
-            bps = pbar.currval / pbar.seconds_elapsed
-        spd = bps
-        for u in self.prefixes:
-            if spd < 1000:
-                break
-            spd /= 1000
-        return self.fmt % (spd, u + self.unit + '/s')
-
-class RotatingMarker(ProgressBarWidget):
-    "A rotating marker for filling the bar of progress."
-    def __init__(self, markers='|/-\\'):
-        self.markers = markers
-        self.curmark = -1
-    def update(self, pbar):
-        if pbar.finished:
-            return self.markers[0]
-        self.curmark = (self.curmark + 1) % len(self.markers)
-        return self.markers[self.curmark]
-
-class Percentage(ProgressBarWidget):
-    "Just the percentage done."
-    def update(self, pbar):
-        return '%3d%%' % pbar.percentage()
-
-class SimpleProgress(ProgressBarWidget):
-    "Returns what is already done and the total, e.g.: '5 of 47'"
-    def __init__(self, sep=' of '):
-        self.sep = sep
-    def update(self, pbar):
-        return '%d%s%d' % (pbar.currval, self.sep, pbar.maxval)
-
-class Bar(ProgressBarWidgetHFill):
-    "The bar of progress. It will stretch to fill the line."
-    def __init__(self, marker='#', left='|', right='|'):
-        self.marker = marker
-        self.left = left
-        self.right = right
-    def _format_marker(self, pbar):
-        if isinstance(self.marker, basestring):
-            return self.marker
-        else:
-            return self.marker.update(pbar)
-    def update(self, pbar, width):
-        percent = pbar.percentage()
-        cwidth = width - len(self.left) - len(self.right)
-        marked_width = int(percent * cwidth // 100)
-        m = self._format_marker(pbar)
-        bar = (self.left + (m * marked_width).ljust(cwidth) + self.right)
-        return bar
-
-class ReverseBar(Bar):
-    "The reverse bar of progress, or bar of regress. :)"
-    def update(self, pbar, width):
-        percent = pbar.percentage()
-        cwidth = width - len(self.left) - len(self.right)
-        marked_width = int(percent * cwidth // 100)
-        m = self._format_marker(pbar)
-        bar = (self.left + (m*marked_width).rjust(cwidth) + self.right)
-        return bar
-
-default_widgets = [Percentage(), ' ', Bar()]
-class ProgressBar(object):
-    """This is the ProgressBar class, it updates and prints the bar.
-
-    A common way of using it is like:
-    >>> pbar = ProgressBar().start()
-    >>> for i in xrange(100):
-    ...    # do something
-    ...    pbar.update(i+1)
-    ...
-    >>> pbar.finish()
-
-    You can also use a progressbar as an iterator:
-    >>> progress = ProgressBar()
-    >>> for i in progress(some_iterable):
-    ...    # do something
-    ...
-
-    But anything you want to do is possible (well, almost anything).
-    You can supply different widgets of any type in any order. And you
-    can even write your own widgets! There are many widgets already
-    shipped and you should experiment with them.
-
-    The term_width parameter must be an integer or None. In the latter case
-    it will try to guess it, if it fails it will default to 80 columns.
-
-    When implementing a widget update method you may access any
-    attribute or function of the ProgressBar object calling the
-    widget's update method. The most important attributes you would
-    like to access are:
-    - currval: current value of the progress, 0 <= currval <= maxval
-    - maxval: maximum (and final) value of the progress
-    - finished: True if the bar has finished (reached 100%), False o/w
-    - start_time: the time when start() method of ProgressBar was called
-    - seconds_elapsed: seconds elapsed since start_time
-    - percentage(): percentage of the progress [0..100]. This is a method.
-
-    The attributes above are unlikely to change between different versions,
-    the other ones may change or cease to exist without notice, so try to rely
-    only on the ones documented above if you are extending the progress bar.
-    """
-
-    __slots__ = ('currval', 'fd', 'finished', 'last_update_time', 'maxval',
-                 'next_update', 'num_intervals', 'seconds_elapsed',
-                 'signal_set', 'start_time', 'term_width', 'update_interval',
-                 'widgets', '_iterable')
-
-    _DEFAULT_MAXVAL = 100
-
-    def __init__(self, maxval=None, widgets=default_widgets, term_width=None,
-                 fd=sys.stderr):
-        self.maxval = maxval
-        self.widgets = widgets
-        self.fd = fd
-        self.signal_set = False
-        if term_width is not None:
-            self.term_width = term_width
-        else:
-            try:
-                self._handle_resize(None, None)
-                signal.signal(signal.SIGWINCH, self._handle_resize)
-                self.signal_set = True
-            except (SystemExit, KeyboardInterrupt):
-                raise
-            except:
-                self.term_width = int(os.environ.get('COLUMNS', 80)) - 1
-
-        self.currval = 0
-        self.finished = False
-        self.start_time = None
-        self.last_update_time = None
-        self.seconds_elapsed = 0
-        self._iterable = None
-
-    def __call__(self, iterable):
-        try:
-            self.maxval = len(iterable)
-        except TypeError:
-            # If the iterable has no length, then rely on the value provided
-            # by the user, otherwise fail.
-            if not (isinstance(self.maxval, (int, long)) and self.maxval > 0):
-                raise RuntimeError('Could not determine maxval from iterable. '
-                                   'You must explicitly provide a maxval.')
-        self._iterable = iter(iterable)
-        self.start()
-        return self
-
-    def __iter__(self):
-        return self
-
-    def next(self):
-        try:
-            next = self._iterable.next()
-            self.update(self.currval + 1)
-            return next
-        except StopIteration:
-            self.finish()
-            raise
-
-    def _handle_resize(self, signum, frame):
-        h, w = array('h', ioctl(self.fd, termios.TIOCGWINSZ, '\0' * 8))[:2]
-        self.term_width = w
-
-    def percentage(self):
-        "Returns the percentage of the progress."
-        return self.currval * 100.0 / self.maxval
-
-    def _format_widgets(self):
-        r = []
-        hfill_inds = []
-        num_hfill = 0
-        currwidth = 0
-        for i, w in enumerate(self.widgets):
-            if isinstance(w, ProgressBarWidgetHFill):
-                r.append(w)
-                hfill_inds.append(i)
-                num_hfill += 1
-            elif isinstance(w, basestring):
-                r.append(w)
-                currwidth += len(w)
-            else:
-                weval = w.update(self)
-                currwidth += len(weval)
-                r.append(weval)
-        for iw in hfill_inds:
-            widget_width = int((self.term_width - currwidth) // num_hfill)
-            r[iw] = r[iw].update(self, widget_width)
-        return r
-
-    def _format_line(self):
-        return ''.join(self._format_widgets()).ljust(self.term_width)
-
-    def _next_update(self):
-        return int((int(self.num_intervals *
-                        (self.currval / self.maxval)) + 1) *
-                   self.update_interval)
-
-    def _need_update(self):
-        """Returns true when the progressbar should print an updated line.
-
-        You can override this method if you want finer grained control over
-        updates.
-
-        The current implementation is optimized to be as fast as possible and
-        as economical as possible in the number of updates. However, depending
-        on your usage you may want to do more updates. For instance, if your
-        progressbar stays in the same percentage for a long time, and you want
-        to update other widgets, like ETA, then you could return True after
-        some time has passed with no updates.
-
-        Ideally you could call self._format_line() and see if it's different
-        from the previous _format_line() call, but calling _format_line() takes
-        around 20 times more time than calling this implementation of
-        _need_update().
-        """
-        return self.currval >= self.next_update
-
-    def update(self, value):
-        "Updates the progress bar to a new value."
-        assert 0 <= value <= self.maxval, '0 <= %d <= %d' % (value, self.maxval)
-        self.currval = value
-        if not self._need_update():
-            return
-        if self.start_time is None:
-            raise RuntimeError('You must call start() before calling update()')
-        now = time.time()
-        self.seconds_elapsed = now - self.start_time
-        self.next_update = self._next_update()
-        self.fd.write(self._format_line() + '\r')
-        self.last_update_time = now
-
-    def start(self):
-        """Starts measuring time, and prints the bar at 0%.
-
-        It returns self so you can use it like this:
-        >>> pbar = ProgressBar().start()
-        >>> for i in xrange(100):
-        ...    # do something
-        ...    pbar.update(i+1)
-        ...
-        >>> pbar.finish()
-        """
-        if self.maxval is None:
-            self.maxval = self._DEFAULT_MAXVAL
-        assert self.maxval > 0
-
-        self.num_intervals = max(100, self.term_width)
-        self.update_interval = self.maxval / self.num_intervals
-        self.next_update = 0
-
-        self.start_time = self.last_update_time = time.time()
-        self.update(0)
-        return self
-
-    def finish(self):
-        """Used to tell the progress is finished."""
-        self.finished = True
-        self.update(self.maxval)
-        self.fd.write('\n')
-        if self.signal_set:
-            signal.signal(signal.SIGWINCH, signal.SIG_DFL)
diff --git a/lib/progressbar/LICENSE.txt b/lib/progressbar/LICENSE.txt
new file mode 100644
index 0000000..fc8ccdc
--- /dev/null
+++ b/lib/progressbar/LICENSE.txt
@@ -0,0 +1,52 @@
+You can redistribute and/or modify this library under the terms of the
+GNU LGPL license or BSD license (or both).
+
+---
+
+progressbar - Text progress bar library for python.
+Copyright (C) 2005 Nilton Volpato
+
+This library is free software; you can redistribute it and/or
+modify it under the terms of the GNU Lesser General Public
+License as published by the Free Software Foundation; either
+version 2.1 of the License, or (at your option) any later version.
+
+This library is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+Lesser General Public License for more details.
+
+You should have received a copy of the GNU Lesser General Public
+License along with this library; if not, write to the Free Software
+Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+---
+
+progressbar - Text progress bar library for python
+Copyright (c) 2008 Nilton Volpato
+
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are met:
+
+ a. Redistributions of source code must retain the above copyright notice,
+    this list of conditions and the following disclaimer.
+ b. Redistributions in binary form must reproduce the above copyright
+    notice, this list of conditions and the following disclaimer in the
+    documentation and/or other materials provided with the distribution.
+ c. Neither the name of the author nor the names of its contributors
+    may be used to endorse or promote products derived from this software
+    without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR
+ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+DAMAGE.
diff --git a/lib/progressbar/__init__.py b/lib/progressbar/__init__.py
new file mode 100644
index 0000000..fbab744
--- /dev/null
+++ b/lib/progressbar/__init__.py
@@ -0,0 +1,49 @@
+#!/usr/bin/python
+# -*- coding: utf-8 -*-
+#
+# progressbar  - Text progress bar library for Python.
+# Copyright (c) 2005 Nilton Volpato
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+"""Text progress bar library for Python.
+
+A text progress bar is typically used to display the progress of a long
+running operation, providing a visual cue that processing is underway.
+
+The ProgressBar class manages the current progress, and the format of the line
+is given by a number of widgets. A widget is an object that may display
+differently depending on the state of the progress bar. There are three types
+of widgets:
+ - a string, which always shows itself
+
+ - a ProgressBarWidget, which may return a different value every time its
+   update method is called
+
+ - a ProgressBarWidgetHFill, which is like ProgressBarWidget, except it
+   expands to fill the remaining width of the line.
+
+The progressbar module is very easy to use, yet very powerful. It will also
+automatically enable features like auto-resizing when the system supports it.
+"""
+
+__author__ = 'Nilton Volpato'
+__author_email__ = 'first-name dot last-name @ gmail.com'
+__date__ = '2011-05-14'
+__version__ = '2.3'
+
+from .compat import *
+from .widgets import *
+from .progressbar import *
diff --git a/lib/progressbar/compat.py b/lib/progressbar/compat.py
new file mode 100644
index 0000000..a39f4a1
--- /dev/null
+++ b/lib/progressbar/compat.py
@@ -0,0 +1,44 @@
+# -*- coding: utf-8 -*-
+#
+# progressbar  - Text progress bar library for Python.
+# Copyright (c) 2005 Nilton Volpato
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+"""Compatibility methods and classes for the progressbar module."""
+
+
+# Python 3.x (and backports) use a modified iterator syntax
+# This will allow 2.x to behave with 3.x iterators
+try:
+  next
+except NameError:
+    def next(iter):
+        try:
+            # Try new style iterators
+            return iter.__next__()
+        except AttributeError:
+            # Fallback in case of a "native" iterator
+            return iter.next()
+
+
+# Python < 2.5 does not have "any"
+try:
+  any
+except NameError:
+   def any(iterator):
+      for item in iterator:
+         if item: return True
+      return False
diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar.py
new file mode 100644
index 0000000..0b9dcf7
--- /dev/null
+++ b/lib/progressbar/progressbar.py
@@ -0,0 +1,307 @@
+# -*- coding: utf-8 -*-
+#
+# progressbar  - Text progress bar library for Python.
+# Copyright (c) 2005 Nilton Volpato
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+"""Main ProgressBar class."""
+
+from __future__ import division
+
+import math
+import os
+import signal
+import sys
+import time
+
+try:
+    from fcntl import ioctl
+    from array import array
+    import termios
+except ImportError:
+    pass
+
+from .compat import *  # for: any, next
+from . import widgets
+
+
+class UnknownLength: pass
+
+
+class ProgressBar(object):
+    """The ProgressBar class which updates and prints the bar.
+
+    A common way of using it is like:
+    >>> pbar = ProgressBar().start()
+    >>> for i in range(100):
+    ...    # do something
+    ...    pbar.update(i+1)
+    ...
+    >>> pbar.finish()
+
+    You can also use a ProgressBar as an iterator:
+    >>> progress = ProgressBar()
+    >>> for i in progress(some_iterable):
+    ...    # do something
+    ...
+
+    Since the progress bar is incredibly customizable you can specify
+    different widgets of any type in any order. You can even write your own
+    widgets! However, since there are already a good number of widgets you
+    should probably play around with them before moving on to create your own
+    widgets.
+
+    The term_width parameter represents the current terminal width. If the
+    parameter is set to an integer then the progress bar will use that,
+    otherwise it will attempt to determine the terminal width falling back to
+    80 columns if the width cannot be determined.
+
+    When implementing a widget's update method you are passed a reference to
+    the current progress bar. As a result, you have access to the
+    ProgressBar's methods and attributes. Although there is nothing preventing
+    you from changing the ProgressBar you should treat it as read only.
+
+    Useful methods and attributes include (Public API):
+     - currval: current progress (0 <= currval <= maxval)
+     - maxval: maximum (and final) value
+     - finished: True if the bar has finished (reached 100%)
+     - start_time: the time when start() method of ProgressBar was called
+     - seconds_elapsed: seconds elapsed since start_time and last call to
+                        update
+     - percentage(): progress in percent [0..100]
+    """
+
+    __slots__ = ('currval', 'fd', 'finished', 'last_update_time',
+                 'left_justify', 'maxval', 'next_update', 'num_intervals',
+                 'poll', 'seconds_elapsed', 'signal_set', 'start_time',
+                 'term_width', 'update_interval', 'widgets', '_time_sensitive',
+                 '__iterable')
+
+    _DEFAULT_MAXVAL = 100
+    _DEFAULT_TERMSIZE = 80
+    _DEFAULT_WIDGETS = [widgets.Percentage(), ' ', widgets.Bar()]
+
+    def __init__(self, maxval=None, widgets=None, term_width=None, poll=1,
+                 left_justify=True, fd=sys.stderr):
+        """Initializes a progress bar with sane defaults."""
+
+        # Don't share a reference with any other progress bars
+        if widgets is None:
+            widgets = list(self._DEFAULT_WIDGETS)
+
+        self.maxval = maxval
+        self.widgets = widgets
+        self.fd = fd
+        self.left_justify = left_justify
+
+        self.signal_set = False
+        if term_width is not None:
+            self.term_width = term_width
+        else:
+            try:
+                self._handle_resize(None, None)
+                signal.signal(signal.SIGWINCH, self._handle_resize)
+                self.signal_set = True
+            except (SystemExit, KeyboardInterrupt): raise
+            except Exception as e:
+                print("DEBUG 5 %s" % e)
+                self.term_width = self._env_size()
+
+        self.__iterable = None
+        self._update_widgets()
+        self.currval = 0
+        self.finished = False
+        self.last_update_time = None
+        self.poll = poll
+        self.seconds_elapsed = 0
+        self.start_time = None
+        self.update_interval = 1
+        self.next_update = 0
+
+
+    def __call__(self, iterable):
+        """Use a ProgressBar to iterate through an iterable."""
+
+        try:
+            self.maxval = len(iterable)
+        except:
+            if self.maxval is None:
+                self.maxval = UnknownLength
+
+        self.__iterable = iter(iterable)
+        return self
+
+
+    def __iter__(self):
+        return self
+
+
+    def __next__(self):
+        try:
+            value = next(self.__iterable)
+            if self.start_time is None:
+                self.start()
+            else:
+                self.update(self.currval + 1)
+            return value
+        except StopIteration:
+            if self.start_time is None:
+                self.start()
+            self.finish()
+            raise
+
+
+    # Create an alias so that Python 2.x won't complain about not being
+    # an iterator.
+    next = __next__
+
+
+    def _env_size(self):
+        """Tries to find the term_width from the environment."""
+
+        return int(os.environ.get('COLUMNS', self._DEFAULT_TERMSIZE)) - 1
+
+
+    def _handle_resize(self, signum=None, frame=None):
+        """Tries to catch resize signals sent from the terminal."""
+
+        h, w = array('h', ioctl(self.fd, termios.TIOCGWINSZ, '\0' * 8))[:2]
+        self.term_width = w
+
+
+    def percentage(self):
+        """Returns the progress as a percentage."""
+        if self.currval >= self.maxval:
+            return 100.0
+        return (self.currval * 100.0 / self.maxval) if self.maxval else 100.00
+
+    percent = property(percentage)
+
+
+    def _format_widgets(self):
+        result = []
+        expanding = []
+        width = self.term_width
+
+        for index, widget in enumerate(self.widgets):
+            if isinstance(widget, widgets.WidgetHFill):
+                result.append(widget)
+                expanding.insert(0, index)
+            else:
+                widget = widgets.format_updatable(widget, self)
+                result.append(widget)
+                width -= len(widget)
+
+        count = len(expanding)
+        while count:
+            portion = max(int(math.ceil(width * 1. / count)), 0)
+            index = expanding.pop()
+            count -= 1
+
+            widget = result[index].update(self, portion)
+            width -= len(widget)
+            result[index] = widget
+
+        return result
+
+
+    def _format_line(self):
+        """Joins the widgets and justifies the line."""
+
+        widgets = ''.join(self._format_widgets())
+
+        if self.left_justify: return widgets.ljust(self.term_width)
+        else: return widgets.rjust(self.term_width)
+
+
+    def _need_update(self):
+        """Returns whether the ProgressBar should redraw the line."""
+        if self.currval >= self.next_update or self.finished: return True
+
+        delta = time.time() - self.last_update_time
+        return self._time_sensitive and delta > self.poll
+
+
+    def _update_widgets(self):
+        """Checks all widgets for the time sensitive bit."""
+
+        self._time_sensitive = any(getattr(w, 'TIME_SENSITIVE', False)
+                                    for w in self.widgets)
+
+
+    def update(self, value=None):
+        """Updates the ProgressBar to a new value."""
+
+        if value is not None and value is not UnknownLength:
+            if (self.maxval is not UnknownLength
+                and not 0 <= value <= self.maxval):
+
+                raise ValueError('Value out of range')
+
+            self.currval = value
+
+
+        if not self._need_update(): return
+        if self.start_time is None:
+            raise RuntimeError('You must call "start" before calling "update"')
+
+        now = time.time()
+        self.seconds_elapsed = now - self.start_time
+        self.next_update = self.currval + self.update_interval
+        self.fd.write(self._format_line() + '\r')
+        self.fd.flush()
+        self.last_update_time = now
+
+
+    def start(self):
+        """Starts measuring time, and prints the bar at 0%.
+
+        It returns self so you can use it like this:
+        >>> pbar = ProgressBar().start()
+        >>> for i in range(100):
+        ...    # do something
+        ...    pbar.update(i+1)
+        ...
+        >>> pbar.finish()
+        """
+
+        if self.maxval is None:
+            self.maxval = self._DEFAULT_MAXVAL
+
+        self.num_intervals = max(100, self.term_width)
+        self.next_update = 0
+
+        if self.maxval is not UnknownLength:
+            if self.maxval < 0: raise ValueError('Value out of range')
+            self.update_interval = self.maxval / self.num_intervals
+
+
+        self.start_time = self.last_update_time = time.time()
+        self.update(0)
+
+        return self
+
+
+    def finish(self):
+        """Puts the ProgressBar bar in the finished state."""
+
+        if self.finished:
+            return
+        self.finished = True
+        self.update(self.maxval)
+        self.fd.write('\n')
+        if self.signal_set:
+            signal.signal(signal.SIGWINCH, signal.SIG_DFL)
diff --git a/lib/progressbar/widgets.py b/lib/progressbar/widgets.py
new file mode 100644
index 0000000..6434ad5
--- /dev/null
+++ b/lib/progressbar/widgets.py
@@ -0,0 +1,355 @@
+# -*- coding: utf-8 -*-
+#
+# progressbar  - Text progress bar library for Python.
+# Copyright (c) 2005 Nilton Volpato
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+"""Default ProgressBar widgets."""
+
+from __future__ import division
+
+import datetime
+import math
+
+try:
+    from abc import ABCMeta, abstractmethod
+except ImportError:
+    AbstractWidget = object
+    abstractmethod = lambda fn: fn
+else:
+    AbstractWidget = ABCMeta('AbstractWidget', (object,), {})
+
+
+def format_updatable(updatable, pbar):
+    if hasattr(updatable, 'update'): return updatable.update(pbar)
+    else: return updatable
+
+
+class Widget(AbstractWidget):
+    """The base class for all widgets.
+
+    The ProgressBar will call the widget's update value when the widget should
+    be updated. The widget's size may change between calls, but the widget may
+    display incorrectly if the size changes drastically and repeatedly.
+
+    The boolean TIME_SENSITIVE informs the ProgressBar that it should be
+    updated more often because it is time sensitive.
+    """
+
+    TIME_SENSITIVE = False
+    __slots__ = ()
+
+    @abstractmethod
+    def update(self, pbar):
+        """Updates the widget.
+
+        pbar - a reference to the calling ProgressBar
+        """
+
+
+class WidgetHFill(Widget):
+    """The base class for all variable width widgets.
+
+    This widget is much like the \\hfill command in TeX, it will expand to
+    fill the line. You can use more than one in the same line, and they will
+    all have the same width, and together will fill the line.
+    """
+
+    @abstractmethod
+    def update(self, pbar, width):
+        """Updates the widget providing the total width the widget must fill.
+
+        pbar - a reference to the calling ProgressBar
+        width - The total width the widget must fill
+        """
+
+
+class Timer(Widget):
+    """Widget which displays the elapsed seconds."""
+
+    __slots__ = ('format_string',)
+    TIME_SENSITIVE = True
+
+    def __init__(self, format='Elapsed Time: %s'):
+        self.format_string = format
+
+    @staticmethod
+    def format_time(seconds):
+        """Formats time as the string "HH:MM:SS"."""
+
+        return str(datetime.timedelta(seconds=int(seconds)))
+
+
+    def update(self, pbar):
+        """Updates the widget to show the elapsed time."""
+
+        return self.format_string % self.format_time(pbar.seconds_elapsed)
+
+
+class ETA(Timer):
+    """Widget which attempts to estimate the time of arrival."""
+
+    TIME_SENSITIVE = True
+
+    def update(self, pbar):
+        """Updates the widget to show the ETA or total time when finished."""
+
+        if pbar.currval == 0:
+            return 'ETA:  --:--:--'
+        elif pbar.finished:
+            return 'Time: %s' % self.format_time(pbar.seconds_elapsed)
+        else:
+            elapsed = pbar.seconds_elapsed
+            eta = elapsed * pbar.maxval / pbar.currval - elapsed
+            return 'ETA:  %s' % self.format_time(eta)
+
+
+class AdaptiveETA(Timer):
+    """Widget which attempts to estimate the time of arrival.
+
+    Uses a weighted average of two estimates:
+      1) ETA based on the total progress and time elapsed so far
+      2) ETA based on the progress as per the last 10 update reports
+
+    The weight depends on the current progress so that to begin with the
+    total progress is used and at the end only the most recent progress is
+    used.
+    """
+
+    TIME_SENSITIVE = True
+    NUM_SAMPLES = 10
+
+    def _update_samples(self, currval, elapsed):
+        sample = (currval, elapsed)
+        if not hasattr(self, 'samples'):
+            self.samples = [sample] * (self.NUM_SAMPLES + 1)
+        else:
+            self.samples.append(sample)
+        return self.samples.pop(0)
+
+    def _eta(self, maxval, currval, elapsed):
+        return elapsed * maxval / float(currval) - elapsed
+
+    def update(self, pbar):
+        """Updates the widget to show the ETA or total time when finished."""
+        if pbar.currval == 0:
+            return 'ETA:  --:--:--'
+        elif pbar.finished:
+            return 'Time: %s' % self.format_time(pbar.seconds_elapsed)
+        else:
+            elapsed = pbar.seconds_elapsed
+            currval1, elapsed1 = self._update_samples(pbar.currval, elapsed)
+            eta = self._eta(pbar.maxval, pbar.currval, elapsed)
+            if pbar.currval > currval1:
+                etasamp = self._eta(pbar.maxval - currval1,
+                                    pbar.currval - currval1,
+                                    elapsed - elapsed1)
+                weight = (pbar.currval / float(pbar.maxval)) ** 0.5
+                eta = (1 - weight) * eta + weight * etasamp
+            return 'ETA:  %s' % self.format_time(eta)
+
+
+class FileTransferSpeed(Widget):
+    """Widget for showing the transfer speed (useful for file transfers)."""
+
+    FORMAT = '%6.2f %s%s/s'
+    PREFIXES = ' kMGTPEZY'
+    __slots__ = ('unit',)
+
+    def __init__(self, unit='B'):
+        self.unit = unit
+
+    def update(self, pbar):
+        """Updates the widget with the current SI prefixed speed."""
+
+        if pbar.seconds_elapsed < 2e-6 or pbar.currval < 2e-6: # =~ 0
+            scaled = power = 0
+        else:
+            speed = pbar.currval / pbar.seconds_elapsed
+            power = int(math.log(speed, 1000))
+            scaled = speed / 1000.**power
+
+        return self.FORMAT % (scaled, self.PREFIXES[power], self.unit)
+
+
+class AnimatedMarker(Widget):
+    """An animated marker for the progress bar which defaults to appear as if
+    it were rotating.
+    """
+
+    __slots__ = ('markers', 'curmark')
+
+    def __init__(self, markers='|/-\\'):
+        self.markers = markers
+        self.curmark = -1
+
+    def update(self, pbar):
+        """Updates the widget to show the next marker or the first marker when
+        finished"""
+
+        if pbar.finished: return self.markers[0]
+
+        self.curmark = (self.curmark + 1) % len(self.markers)
+        return self.markers[self.curmark]
+
+# Alias for backwards compatibility
+RotatingMarker = AnimatedMarker
+
+
+class Counter(Widget):
+    """Displays the current count."""
+
+    __slots__ = ('format_string',)
+
+    def __init__(self, format='%d'):
+        self.format_string = format
+
+    def update(self, pbar):
+        return self.format_string % pbar.currval
+
+
+class Percentage(Widget):
+    """Displays the current percentage as a number with a percent sign."""
+
+    def update(self, pbar):
+        return '%3d%%' % pbar.percentage()
+
+
+class FormatLabel(Timer):
+    """Displays a formatted label."""
+
+    mapping = {
+        'elapsed': ('seconds_elapsed', Timer.format_time),
+        'finished': ('finished', None),
+        'last_update': ('last_update_time', None),
+        'max': ('maxval', None),
+        'seconds': ('seconds_elapsed', None),
+        'start': ('start_time', None),
+        'value': ('currval', None)
+    }
+
+    __slots__ = ('format_string',)
+    def __init__(self, format):
+        self.format_string = format
+
+    def update(self, pbar):
+        context = {}
+        for name, (key, transform) in self.mapping.items():
+            try:
+                value = getattr(pbar, key)
+
+                if transform is None:
+                   context[name] = value
+                else:
+                   context[name] = transform(value)
+            except: pass
+
+        return self.format_string % context
+
+
+class SimpleProgress(Widget):
+    """Returns progress as a count of the total (e.g.: "5 of 47")."""
+
+    __slots__ = ('sep',)
+
+    def __init__(self, sep=' of '):
+        self.sep = sep
+
+    def update(self, pbar):
+        return '%d%s%d' % (pbar.currval, self.sep, pbar.maxval)
+
+
+class Bar(WidgetHFill):
+    """A progress bar which stretches to fill the line."""
+
+    __slots__ = ('marker', 'left', 'right', 'fill', 'fill_left')
+
+    def __init__(self, marker='#', left='|', right='|', fill=' ',
+                 fill_left=True):
+        """Creates a customizable progress bar.
+
+        marker - string or updatable object to use as a marker
+        left - string or updatable object to use as a left border
+        right - string or updatable object to use as a right border
+        fill - character to use for the empty part of the progress bar
+        fill_left - whether to fill from the left or the right
+        """
+        self.marker = marker
+        self.left = left
+        self.right = right
+        self.fill = fill
+        self.fill_left = fill_left
+
+
+    def update(self, pbar, width):
+        """Updates the progress bar and its subcomponents."""
+
+        left, marked, right = (format_updatable(i, pbar) for i in
+                               (self.left, self.marker, self.right))
+
+        width -= len(left) + len(right)
+        # Marked must *always* have length of 1
+        if pbar.maxval:
+          marked *= int(pbar.currval / pbar.maxval * width)
+        else:
+          marked = ''
+
+        if self.fill_left:
+            return '%s%s%s' % (left, marked.ljust(width, self.fill), right)
+        else:
+            return '%s%s%s' % (left, marked.rjust(width, self.fill), right)
+
+
+class ReverseBar(Bar):
+    """A bar which has a marker which bounces from side to side."""
+
+    def __init__(self, marker='#', left='|', right='|', fill=' ',
+                 fill_left=False):
+        """Creates a customizable progress bar.
+
+        marker - string or updatable object to use as a marker
+        left - string or updatable object to use as a left border
+        right - string or updatable object to use as a right border
+        fill - character to use for the empty part of the progress bar
+        fill_left - whether to fill from the left or the right
+        """
+        self.marker = marker
+        self.left = left
+        self.right = right
+        self.fill = fill
+        self.fill_left = fill_left
+
+
+class BouncingBar(Bar):
+    def update(self, pbar, width):
+        """Updates the progress bar and its subcomponents."""
+
+        left, marker, right = (format_updatable(i, pbar) for i in
+                               (self.left, self.marker, self.right))
+
+        width -= len(left) + len(right)
+
+        if pbar.finished: return '%s%s%s' % (left, width * marker, right)
+
+        position = int(pbar.currval % (width * 2 - 1))
+        if position > width: position = width * 2 - position
+        lpad = self.fill * (position - 1)
+        rpad = self.fill * (width - len(marker) - len(lpad))
+
+        # Swap if we want to bounce the other way
+        if not self.fill_left: rpad, lpad = lpad, rpad
+
+        return '%s%s%s%s%s' % (left, lpad, marker, rpad, right)
-- 
2.5.5


