Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B61437733E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B9007479; Wed, 1 Jun 2016 13:37:06 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UHlhyO1N41Tb; Wed,  1 Jun 2016 13:37:06 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxHk007444
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nM-64; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:21 +0100
Message-Id: <1464784607-2985-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 02/28] bitbake/pyinotify.py: Upgrade to py3 version
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:09 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/pyinotify.py | 256 ++++++++++++++++++++++---------------------------------
 1 file changed, 101 insertions(+), 155 deletions(-)

diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 2dae002..4eb03b0 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
@@ -42,13 +42,14 @@ class UnsupportedPythonVersionError(PyinotifyError):
         @param version: Current Python version
         @type version: string
         """
-        err = 'Python %s is unsupported, requires at least Python 2.4'
-        PyinotifyError.__init__(self, err % version)
+        PyinotifyError.__init__(self,
+                                ('Python %s is unsupported, requires '
+                                 'at least Python 3.0') % version)
 
 
 # Check Python version
 import sys
-if sys.version_info < (2, 4):
+if sys.version_info < (3, 0):
     raise UnsupportedPythonVersionError(sys.version)
 
 
@@ -68,6 +69,8 @@ from datetime import datetime, timedelta
 import time
 import re
 import asyncore
+import glob
+import locale
 import subprocess
 
 try:
@@ -76,12 +79,6 @@ except ImportError:
     pass  # Will fail on Python 2.4 which has reduce() builtin anyway.
 
 try:
-    from glob import iglob as glob
-except ImportError:
-    # Python 2.4 does not have glob.iglob().
-    from glob import glob as glob
-
-try:
     import ctypes
     import ctypes.util
 except ImportError:
@@ -95,9 +92,7 @@ except ImportError:
 
 __author__ = "seb@dbzteam.org (Sebastien Martini)"
 
-__version__ = "0.9.5"
-
-__metaclass__ = type  # Use new-style classes by default
+__version__ = "0.9.6"
 
 
 # Compatibity mode: set to True to improve compatibility with
@@ -122,6 +117,9 @@ class INotifyWrapper:
     """
     @staticmethod
     def create():
+        """
+        Factory method instanciating and returning the right wrapper.
+        """
         # First, try to use ctypes.
         if ctypes:
             inotify = _CtypesLibcINotifyWrapper()
@@ -173,7 +171,7 @@ class _INotifySyscallsWrapper(INotifyWrapper):
     def _inotify_init(self):
         try:
             fd = inotify_syscalls.inotify_init()
-        except IOError, err:
+        except IOError as err:
             self._last_errno = err.errno
             return -1
         return fd
@@ -181,7 +179,7 @@ class _INotifySyscallsWrapper(INotifyWrapper):
     def _inotify_add_watch(self, fd, pathname, mask):
         try:
             wd = inotify_syscalls.inotify_add_watch(fd, pathname, mask)
-        except IOError, err:
+        except IOError as err:
             self._last_errno = err.errno
             return -1
         return wd
@@ -189,7 +187,7 @@ class _INotifySyscallsWrapper(INotifyWrapper):
     def _inotify_rm_watch(self, fd, wd):
         try:
             ret = inotify_syscalls.inotify_rm_watch(fd, wd)
-        except IOError, err:
+        except IOError as err:
             self._last_errno = err.errno
             return -1
         return ret
@@ -213,17 +211,8 @@ class _CtypesLibcINotifyWrapper(INotifyWrapper):
         except (OSError, IOError):
             pass  # Will attemp to load it with None anyway.
 
-        if sys.version_info >= (2, 6):
-            self._libc = ctypes.CDLL(libc_name, use_errno=True)
-            self._get_errno_func = ctypes.get_errno
-        else:
-            self._libc = ctypes.CDLL(libc_name)
-            try:
-                location = self._libc.__errno_location
-                location.restype = ctypes.POINTER(ctypes.c_int)
-                self._get_errno_func = lambda: location().contents.value
-            except AttributeError:
-                pass
+        self._libc = ctypes.CDLL(libc_name, use_errno=True)
+        self._get_errno_func = ctypes.get_errno
 
         # Eventually check that libc has needed inotify bindings.
         if (not hasattr(self._libc, 'inotify_init') or
@@ -241,9 +230,8 @@ class _CtypesLibcINotifyWrapper(INotifyWrapper):
         return True
 
     def _get_errno(self):
-        if self._get_errno_func is not None:
-            return self._get_errno_func()
-        return None
+        assert self._get_errno_func
+        return self._get_errno_func()
 
     def _inotify_init(self):
         assert self._libc is not None
@@ -251,6 +239,11 @@ class _CtypesLibcINotifyWrapper(INotifyWrapper):
 
     def _inotify_add_watch(self, fd, pathname, mask):
         assert self._libc is not None
+        # Encodes path to a bytes string. This conversion seems required because
+        # ctypes.create_string_buffer seems to manipulate bytes internally.
+        # Moreover it seems that inotify_add_watch does not work very well when
+        # it receives an ctypes.create_unicode_buffer instance as argument.
+        pathname = pathname.encode(sys.getfilesystemencoding())
         pathname = ctypes.create_string_buffer(pathname)
         return self._libc.inotify_add_watch(fd, pathname, mask)
 
@@ -258,10 +251,6 @@ class _CtypesLibcINotifyWrapper(INotifyWrapper):
         assert self._libc is not None
         return self._libc.inotify_rm_watch(fd, wd)
 
-    def _sysctl(self, *args):
-        assert self._libc is not None
-        return self._libc.sysctl(*args)
-
 
 # Logging
 def logger_init():
@@ -278,97 +267,58 @@ log = logger_init()
 
 
 # inotify's variables
-class SysCtlINotify:
+class ProcINotify:
     """
-    Access (read, write) inotify's variables through sysctl. Usually it
-    requires administrator rights to update them.
+    Access (read, write) inotify's variables through /proc/sys/. Note that
+    usually it requires administrator rights to update them.
 
     Examples:
       - Read max_queued_events attribute: myvar = max_queued_events.value
       - Update max_queued_events attribute: max_queued_events.value = 42
     """
-
-    inotify_attrs = {'max_user_instances': 1,
-                     'max_user_watches': 2,
-                     'max_queued_events': 3}
-
-    def __init__(self, attrname, inotify_wrapper):
-        # FIXME: right now only supporting ctypes
-        assert ctypes
-        self._attrname = attrname
-        self._inotify_wrapper = inotify_wrapper
-        sino = ctypes.c_int * 3
-        self._attr = sino(5, 20, SysCtlINotify.inotify_attrs[attrname])
-
-    @staticmethod
-    def create(attrname):
-        """
-        Factory method instanciating and returning the right wrapper.
-        """
-        # FIXME: right now only supporting ctypes
-        if ctypes is None:
-            return None
-        inotify_wrapper = _CtypesLibcINotifyWrapper()
-        if not inotify_wrapper.init():
-            return None
-        return SysCtlINotify(attrname, inotify_wrapper)
+    def __init__(self, attr):
+        self._base = "/proc/sys/fs/inotify"
+        self._attr = attr
 
     def get_val(self):
         """
-        Gets attribute's value. Raises OSError if the operation failed.
+        Gets attribute's value.
 
         @return: stored value.
         @rtype: int
+        @raise IOError: if corresponding file in /proc/sys cannot be read.
         """
-        oldv = ctypes.c_int(0)
-        size = ctypes.c_int(ctypes.sizeof(oldv))
-        sysctl = self._inotify_wrapper._sysctl
-        res = sysctl(self._attr, 3,
-                     ctypes.c_voidp(ctypes.addressof(oldv)),
-                     ctypes.addressof(size),
-                     None, 0)
-        if res == -1:
-            raise OSError(self._inotify_wrapper.get_errno(),
-                          self._inotify_wrapper.str_errno())
-        return oldv.value
+        with open(os.path.join(self._base, self._attr), 'r') as file_obj:
+            return int(file_obj.readline())
 
     def set_val(self, nval):
         """
-        Sets new attribute's value. Raises OSError if the operation failed.
+        Sets new attribute's value.
 
         @param nval: replaces current value by nval.
         @type nval: int
+        @raise IOError: if corresponding file in /proc/sys cannot be written.
         """
-        oldv = ctypes.c_int(0)
-        sizeo = ctypes.c_int(ctypes.sizeof(oldv))
-        newv = ctypes.c_int(nval)
-        sizen = ctypes.c_int(ctypes.sizeof(newv))
-        sysctl = self._inotify_wrapper._sysctl
-        res = sysctl(self._attr, 3,
-                     ctypes.c_voidp(ctypes.addressof(oldv)),
-                     ctypes.addressof(sizeo),
-                     ctypes.c_voidp(ctypes.addressof(newv)),
-                     sizen)
-        if res == -1:
-            raise OSError(self._inotify_wrapper.get_errno(),
-                          self._inotify_wrapper.str_errno())
+        with open(os.path.join(self._base, self._attr), 'w') as file_obj:
+            file_obj.write(str(nval) + '\n')
 
     value = property(get_val, set_val)
 
     def __repr__(self):
-        return '<%s=%d>' % (self._attrname, self.get_val())
+        return '<%s=%d>' % (self._attr, self.get_val())
 
 
 # Inotify's variables
 #
-# FIXME: currently these variables are only accessible when ctypes is used,
-#        otherwise there are set to None.
+# Note: may raise IOError if the corresponding value in /proc/sys
+#       cannot be accessed.
 #
-# read: myvar = max_queued_events.value
-# update: max_queued_events.value = 42
+# Examples:
+#  - read: myvar = max_queued_events.value
+#  - update: max_queued_events.value = 42
 #
 for attrname in ('max_queued_events', 'max_user_instances', 'max_user_watches'):
-    globals()[attrname] = SysCtlINotify.create(attrname)
+    globals()[attrname] = ProcINotify(attrname)
 
 
 class EventsCodes:
@@ -536,7 +486,7 @@ class _Event:
                 continue
             if attr == 'mask':
                 value = hex(getattr(self, attr))
-            elif isinstance(value, basestring) and not value:
+            elif isinstance(value, str) and not value:
                 value = "''"
             s += ' %s%s%s' % (output_format.field_name(attr),
                               output_format.punctuation('='),
@@ -628,7 +578,7 @@ class Event(_Event):
                                                              self.name))
             else:
                 self.pathname = os.path.abspath(self.path)
-        except AttributeError, err:
+        except AttributeError as err:
             # Usually it is not an error some events are perfectly valids
             # despite the lack of these attributes.
             log.debug(err)
@@ -718,8 +668,8 @@ class _SysProcessEvent(_ProcessEvent):
         and self._mv.
         """
         date_cur_ = datetime.now()
-        for seq in [self._mv_cookie, self._mv]:
-            for k in seq.keys():
+        for seq in (self._mv_cookie, self._mv):
+            for k in list(seq.keys()):
                 if (date_cur_ - seq[k][1]) > timedelta(minutes=1):
                     log.debug('Cleanup: deleting entry %s', seq[k][0])
                     del seq[k]
@@ -767,9 +717,9 @@ class _SysProcessEvent(_ProcessEvent):
                                 continue
                             rawevent = _RawEvent(created_dir_wd, flags, 0, name)
                             self._notifier.append_event(rawevent)
-                    except OSError, err:
-                        msg = "process_IN_CREATE, invalid directory %s: %s"
-                        log.debug(msg % (created_dir, str(err)))
+                    except OSError as err:
+                        msg = "process_IN_CREATE, invalid directory: %s"
+                        log.debug(msg % str(err))
         return self.process_default(raw_event)
 
     def process_IN_MOVED_FROM(self, raw_event):
@@ -1097,8 +1047,8 @@ class Stats(ProcessEvent):
         @type filename: string
         """
         flags = os.O_WRONLY|os.O_CREAT|os.O_NOFOLLOW|os.O_EXCL
-        fd = os.open(filename, flags, 0600)
-        os.write(fd, str(self))
+        fd = os.open(filename, flags, 0o0600)
+        os.write(fd, bytes(self.__str__(), locale.getpreferredencoding()))
         os.close(fd)
 
     def __str__(self, scale=45):
@@ -1107,7 +1057,7 @@ class Stats(ProcessEvent):
             return ''
 
         m = max(stats.values())
-        unity = float(scale) / m
+        unity = scale / m
         fmt = '%%-26s%%-%ds%%s' % (len(output_format.field_value('@' * scale))
                                    + 1)
         def func(x):
@@ -1149,7 +1099,7 @@ class Notifier:
         @type default_proc_fun: instance of ProcessEvent
         @param read_freq: if read_freq == 0, events are read asap,
                           if read_freq is > 0, this thread sleeps
-                          max(0, read_freq - timeout) seconds. But if
+                          max(0, read_freq - (timeout / 1000)) seconds. But if
                           timeout is None it may be different because
                           poll is blocking waiting for something to read.
         @type read_freq: int
@@ -1161,8 +1111,9 @@ class Notifier:
                           until the amount of events to read is >= threshold.
                           At least with read_freq set you might sleep.
         @type threshold: int
-        @param timeout:
-            https://docs.python.org/3/library/select.html#polling-objects
+        @param timeout: see read_freq above. If provided, it must be set in
+                        milliseconds. See
+                        https://docs.python.org/3/library/select.html#select.poll.poll
         @type timeout: int
         """
         # Watch Manager instance
@@ -1228,7 +1179,8 @@ class Notifier:
         milliseconds.
 
         @param timeout: If specified it overrides the corresponding instance
-                        attribute _timeout.
+                        attribute _timeout. timeout must be sepcified in
+                        milliseconds.
         @type timeout: int
 
         @return: New events to read.
@@ -1240,8 +1192,8 @@ class Notifier:
                 if timeout is None:
                     timeout = self._timeout
                 ret = self._pollobj.poll(timeout)
-            except select.error, err:
-                if err[0] == errno.EINTR:
+            except select.error as err:
+                if err.args[0] == errno.EINTR:
                     continue # interrupted, retry
                 else:
                     raise
@@ -1271,7 +1223,7 @@ class Notifier:
         try:
             # Read content from file
             r = os.read(self._fd, queue_size)
-        except Exception, msg:
+        except Exception as msg:
             raise NotifierError(msg)
         log.debug('Event queue size: %d', queue_size)
         rsum = 0  # counter
@@ -1281,9 +1233,11 @@ class Notifier:
             wd, mask, cookie, fname_len = struct.unpack('iIII',
                                                         r[rsum:rsum+s_size])
             # Retrieve name
-            fname, = struct.unpack('%ds' % fname_len,
+            bname, = struct.unpack('%ds' % fname_len,
                                    r[rsum + s_size:rsum + s_size + fname_len])
-            rawevent = _RawEvent(wd, mask, cookie, fname)
+            # FIXME: should we explictly call sys.getdefaultencoding() here ??
+            uname = bname.decode()
+            rawevent = _RawEvent(wd, mask, cookie, uname)
             if self._coalesce:
                 # Only enqueue new (unique) events.
                 raweventstr = str(rawevent)
@@ -1326,13 +1280,10 @@ class Notifier:
     def __daemonize(self, pid_file=None, stdin=os.devnull, stdout=os.devnull,
                     stderr=os.devnull):
         """
-        @param pid_file: file where the pid will be written. If pid_file=None
-                         the pid is written to
-                         /var/run/<sys.argv[0]|pyinotify>.pid, if pid_file=False
-                         no pid_file is written.
-        @param stdin:
-        @param stdout:
-        @param stderr: files associated to common streams.
+        pid_file: file where the pid will be written. If pid_file=None the pid
+                  is written to /var/run/<sys.argv[0]|pyinotify>.pid, if
+                  pid_file=False no pid_file is written.
+        stdin, stdout, stderr: files associated to common streams.
         """
         if pid_file is None:
             dirname = '/var/run/'
@@ -1354,7 +1305,7 @@ class Notifier:
                 if (pid == 0):
                     # child
                     os.chdir('/')
-                    os.umask(022)
+                    os.umask(0o022)
                 else:
                     # parent 2
                     os._exit(0)
@@ -1364,9 +1315,9 @@ class Notifier:
 
             fd_inp = os.open(stdin, os.O_RDONLY)
             os.dup2(fd_inp, 0)
-            fd_out = os.open(stdout, os.O_WRONLY|os.O_CREAT, 0600)
+            fd_out = os.open(stdout, os.O_WRONLY|os.O_CREAT, 0o0600)
             os.dup2(fd_out, 1)
-            fd_err = os.open(stderr, os.O_WRONLY|os.O_CREAT, 0600)
+            fd_err = os.open(stderr, os.O_WRONLY|os.O_CREAT, 0o0600)
             os.dup2(fd_err, 2)
 
         # Detach task
@@ -1375,8 +1326,9 @@ class Notifier:
         # Write pid
         if pid_file != False:
             flags = os.O_WRONLY|os.O_CREAT|os.O_NOFOLLOW|os.O_EXCL
-            fd_pid = os.open(pid_file, flags, 0600)
-            os.write(fd_pid, str(os.getpid()) + '\n')
+            fd_pid = os.open(pid_file, flags, 0o0600)
+            os.write(fd_pid,  bytes(str(os.getpid()) + '\n',
+                                    locale.getpreferredencoding()))
             os.close(fd_pid)
             # Register unlink function
             atexit.register(lambda : os.unlink(pid_file))
@@ -1441,9 +1393,12 @@ class Notifier:
         Close inotify's instance (close its file descriptor).
         It destroys all existing watches, pending events,...
         This method is automatically called at the end of loop().
+        Afterward it is invalid to access this instance.
         """
-        self._pollobj.unregister(self._fd)
-        os.close(self._fd)
+        if self._fd is not None:
+            self._pollobj.unregister(self._fd)
+            os.close(self._fd)
+            self._fd = None
         self._sys_proc_fun = None
 
 
@@ -1468,7 +1423,7 @@ class ThreadedNotifier(threading.Thread, Notifier):
         @type default_proc_fun: instance of ProcessEvent
         @param read_freq: if read_freq == 0, events are read asap,
                           if read_freq is > 0, this thread sleeps
-                          max(0, read_freq - timeout) seconds.
+                          max(0, read_freq - (timeout / 1000)) seconds.
         @type read_freq: int
         @param threshold: File descriptor will be read only if the accumulated
                           size to read becomes >= threshold. If != 0, you likely
@@ -1478,8 +1433,9 @@ class ThreadedNotifier(threading.Thread, Notifier):
                           until the amount of events to read is >= threshold. At
                           least with read_freq you might sleep.
         @type threshold: int
-        @param timeout:
-            https://docs.python.org/3/library/select.html#polling-objects
+        @param timeout: see read_freq above. If provided, it must be set in
+                        milliseconds. See
+                        https://docs.python.org/3/library/select.html#select.poll.poll
         @type timeout: int
         """
         # Init threading base class
@@ -1498,7 +1454,7 @@ class ThreadedNotifier(threading.Thread, Notifier):
         Stop notifier's loop. Stop notification. Join the thread.
         """
         self._stop_event.set()
-        os.write(self._pipe[1], 'stop')
+        os.write(self._pipe[1], b'stop')
         threading.Thread.join(self)
         Notifier.stop(self)
         self._pollobj.unregister(self._pipe[0])
@@ -1699,7 +1655,6 @@ class Watch:
 class ExcludeFilter:
     """
     ExcludeFilter is an exclusion filter.
-
     """
     def __init__(self, arg_lst):
         """
@@ -1731,16 +1686,13 @@ class ExcludeFilter:
 
     def _load_patterns_from_file(self, filename):
         lst = []
-        file_obj = file(filename, 'r')
-        try:
+        with open(filename, 'r') as file_obj:
             for line in file_obj.readlines():
                 # Trim leading an trailing whitespaces
                 pattern = line.strip()
                 if not pattern or pattern.startswith('#'):
                     continue
                 lst.append(pattern)
-        finally:
-            file_obj.close()
         return lst
 
     def _match(self, regex, path):
@@ -1764,7 +1716,6 @@ class WatchManagerError(Exception):
     """
     WatchManager Exception. Raised on error encountered on watches
     operations.
-
     """
     def __init__(self, msg, wmd):
         """
@@ -1851,7 +1802,7 @@ class WatchManager:
         """
         try:
             del self._wmd[wd]
-        except KeyError, err:
+        except KeyError as err:
             log.error('Cannot delete unknown watch descriptor %s' % str(err))
 
     @property
@@ -1868,13 +1819,7 @@ class WatchManager:
         """
         Format path to its internal (stored in watch manager) representation.
         """
-        # Unicode strings are converted back to strings, because it seems
-        # that inotify_add_watch from ctypes does not work well when
-        # it receives an ctypes.create_unicode_buffer instance as argument.
-        # Therefore even wd are indexed with bytes string and not with
-        # unicode paths.
-        if isinstance(path, unicode):
-            path = path.encode(sys.getfilesystemencoding())
+        # path must be a unicode string (str) and is just normalized.
         return os.path.normpath(path)
 
     def __add_watch(self, path, mask, proc_fun, auto_add, exclude_filter):
@@ -1890,13 +1835,14 @@ class WatchManager:
             return wd
         watch = Watch(wd=wd, path=path, mask=mask, proc_fun=proc_fun,
                       auto_add=auto_add, exclude_filter=exclude_filter)
+        # wd are _always_ indexed with their original unicode paths in wmd.
         self._wmd[wd] = watch
         log.debug('New %s', watch)
         return wd
 
     def __glob(self, path, do_glob):
         if do_glob:
-            return glob(path)
+            return glob.iglob(path)
         else:
             return [path]
 
@@ -1907,11 +1853,8 @@ class WatchManager:
         Add watch(s) on the provided |path|(s) with associated |mask| flag
         value and optionally with a processing |proc_fun| function and
         recursive flag |rec| set to True.
-        Ideally |path| components should not be unicode objects. Note that
-        although unicode paths are accepted there are converted to byte
-        strings before a watch is put on that path. The encoding used for
-        converting the unicode object is given by sys.getfilesystemencoding().
-        If |path| si already watched it is ignored, but if it is called with
+        All |path| components _must_ be str (i.e. unicode) objects.
+        If |path| is already watched it is ignored, but if it is called with
         option rec=True a watch is put on each one of its not-watched
         subdirectory.
 
@@ -1945,10 +1888,9 @@ class WatchManager:
                                the class' constructor.
         @type exclude_filter: callable object
         @return: dict of paths associated to watch descriptors. A wd value
-                 is positive if the watch was added sucessfully,
-                 otherwise the value is negative. If the path was invalid
-                 or was already watched it is not included into this returned
-                 dictionary.
+                 is positive if the watch was added sucessfully, otherwise
+                 the value is negative. If the path was invalid or was already
+                 watched it is not included into this returned dictionary.
         @rtype: dict of {str: int}
         """
         ret_ = {} # return {path: wd, ...}
@@ -1958,6 +1900,11 @@ class WatchManager:
 
         # normalize args as list elements
         for npath in self.__format_param(path):
+            # Require that path be a unicode string
+            if not isinstance(npath, str):
+                ret_[path] = -3
+                continue
+
             # unix pathname pattern expansion
             for apath in self.__glob(npath, do_glob):
                 # recursively list subdirs according to rec param
@@ -2242,7 +2189,6 @@ class WatchManager:
                              "Make watch manager ignoring new events.")
 
 
-
 class RawOutputFormat:
     """
     Format string representations.
-- 
2.5.0


