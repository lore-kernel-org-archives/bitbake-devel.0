Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC309C433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 17:29:23 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.14161.1639416561223218851
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 09:29:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=cEZoW8S5;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639416561;
  x=1670952561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyAP0rJr4OzXrtRif+A4ZC5/owhsVtnSOVBL76suH0k=;
  b=cEZoW8S5GzHOHr1z3mYzRG829EPZ/M9fzFmoYe2pEvaAFvyNrKVzx2Na
   l+N2jOmIG98oQZHBGokTK2eMsmijzPxzW+WqTXQE71Kf6AXbVmQ5JE7Nn
   jE3yzcUOwmD9OPvg82y/Djj0vGZIyNe04eeAL9fJ64E7ZAborwYc1RTuC
   +LTliW3MDLISTJbYjwoERJl0zMBThL0hzZvgbXOEzCCuETE1rbwxXGPsH
   UVYisMYek5Asabr+hCT2TYF4o4wDXFQZufbdOW8u/PXy9bgej6E1gurjb
   SGDbfyiEkIjreDaJlREDPyLtjoh61FQqLfJw4kpUT0ItKvGpGROSI4v5x
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Joshua Watt <JPEWhacker@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"ross@burtonini.com" <ross@burtonini.com>, "kergoth@gmail.com"
	<kergoth@gmail.com>
Subject: RE: [bitbake-devel][RFC] bitbake-worker: Switch to use asyncio
Thread-Topic: [bitbake-devel][RFC] bitbake-worker: Switch to use asyncio
Thread-Index: AQHX7ryJCI+kSVl3UEyyuSwZwp3Z+awwr93A
Date: Mon, 13 Dec 2021 17:29:09 +0000
Message-ID: <2cb6b6b695de489fb860317d375ac21f@axis.com>
References: <20211211182524.1807371-1-JPEWhacker@gmail.com>
In-Reply-To: <20211211182524.1807371-1-JPEWhacker@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Dec 2021 17:29:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13150

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Joshua Watt
> Sent: den 11 december 2021 19:25
> To: bitbake-devel@lists.openembedded.org
> Cc: richard.purdie@linuxfoundation.org; ross@burtonini.com; kergoth@gmail=
.com; Joshua Watt <JPEWhacker@gmail.com>
> Subject: [bitbake-devel][RFC] bitbake-worker: Switch to use asyncio
>=20
> Switches bitbake-worker to use asyncio. This is a good canidate for
> initial modernization using asyncio because it is self-contained will a

Change "will" to "with".

//Peter

> well defined interface to the bitbake server process.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/bin/bitbake-worker | 554 +++++++++++++++++++------------------
>  1 file changed, 284 insertions(+), 270 deletions(-)
>=20
> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
> index bf96207edc..d5cc4fa248 100755
> --- a/bitbake/bin/bitbake-worker
> +++ b/bitbake/bin/bitbake-worker
> @@ -11,16 +11,14 @@ sys.path.insert(0,
> os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
>  from bb import fetch2
>  import logging
>  import bb
> -import select
>  import errno
>  import signal
>  import pickle
>  import traceback
> -import queue
>  import shlex
>  import subprocess
>  from multiprocessing import Lock
> -from threading import Thread
> +import asyncio
>=20
>  if sys.getfilesystemencoding() !=3D "utf-8":
>      sys.exit("Please use a locale setting which supports UTF-8 (such as
> LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after
> loading so we need a UTF-8 when Python starts or things won't work.")
> @@ -53,14 +51,15 @@ except:
>=20
>  logger =3D logging.getLogger("BitBake")
>=20
> -worker_pipe =3D sys.stdout.fileno()
> -bb.utils.nonblockingfd(worker_pipe)
> -# Need to guard against multiprocessing being used in child processes
> -# and multiple processes trying to write to the parent at the same time
> -worker_pipe_lock =3D None
>=20
> -handler =3D bb.event.LogHandler()
> -logger.addHandler(handler)
> +async def connect_stdout():
> +    loop =3D asyncio.get_event_loop()
> +    w_transport, w_protocol =3D await
> loop.connect_write_pipe(asyncio.streams.FlowControlMixin, sys.stdout)
> +    writer =3D asyncio.StreamWriter(w_transport, w_protocol, None, loop)
> +    return writer
> +
> +log_handler =3D bb.event.LogHandler()
> +logger.addHandler(log_handler)
>=20
>  if 0:
>      # Code to write out a log file of all events passing through the
> worker
> @@ -71,73 +70,270 @@ if 0:
>      consolelog.setFormatter(conlogformat)
>      logger.addHandler(consolelog)
>=20
> -worker_queue =3D queue.Queue()
> -
> -def worker_fire(event, d):
> -    data =3D b"<event>" + pickle.dumps(event) + b"</event>"
> -    worker_fire_prepickled(data)
> +async def read_messages(fd, handlers):
> +    buf =3D b""
> +    event =3D asyncio.Event()
> +    done =3D False
>=20
> -def worker_fire_prepickled(event):
> -    global worker_queue
> +    def read_data():
> +        nonlocal buf
> +        nonlocal fd
> +        nonlocal event
> +        nonlocal done
>=20
> -    worker_queue.put(event)
> +        try:
> +            data =3D os.read(fd, 102400)
> +        except (OSError, IOError) as e:
> +            if e.errno !=3D errno.EAGAIN:
> +                raise
> +            return
>=20
> -#
> -# We can end up with write contention with the cooker, it can be trying
> to send commands
> -# and we can be trying to send event data back. Therefore use a separate
> thread for writing
> -# back data to cooker.
> -#
> -worker_thread_exit =3D False
> +        if len(data) =3D=3D 0:
> +            done =3D True
> +        else:
> +            buf +=3D data
> +        event.set()
>=20
> -def worker_flush(worker_queue):
> -    worker_queue_int =3D b""
> -    global worker_pipe, worker_thread_exit
> +    asyncio.get_event_loop().add_reader(fd, read_data)
>=20
> -    while True:
> +    try:
> +        while not done:
> +            for name, handler in handlers.items():
> +                prefix =3D b"<" + name + b">"
> +                if buf.startswith(prefix):
> +                    suffix =3D b"</" + name + b">"
> +                    index =3D buf.find(suffix)
> +                    if index !=3D -1:
> +                        try:
> +                            workerlog_write("%d: Handling %r\n" % (fd,
> name))
> +                            await handler(buf[len(prefix):index])
> +                        except pickle.UnpicklingError:
> +                            workerlog_write("Unable to unpickle data:
> %s\n" % ":".join("{:02x}".format(c) for c in buf))
> +                            raise
> +
> +                        buf =3D buf[index + len(suffix):]
> +                        break
> +                        # TODO: The old code would keep looking for an
> ending
> +                        # tag in a loop, so that a stream like
> +                        # <A>foo</A>bar</A> was valid. This doesn't
> appear to
> +                        # be necessary anymore?
> +                        #index =3D self.buf.find(b"</" + item + b">")
> +            else:
> +                # Nothing found in the buffer. Wait for more data
> +                await event.wait()
> +                event.clear()
> +    finally:
> +        asyncio.get_event_loop().remove_reader(fd)
> +
> +class ChildHandler(object):
> +    def __init__(self, writer, task, pid, pipeinfd, pipeoutfd):
> +        self.task =3D task
> +        self.writer =3D writer
> +        self.pid =3D pid
> +        self.pipeinfd =3D pipeinfd
> +        if pipeoutfd >=3D 0:
> +            os.close(pipeoutfd)
> +
> +        self.done_event =3D asyncio.Event()
> +        self.loop =3D asyncio.get_running_loop()
> +
> +        asyncio.get_child_watcher().add_child_handler(self.pid,
> self._child_watcher_callback)
> +
> +    def _child_watcher_callback(self, pid, status):
> +        # The callback may be called in a thread, so call_soon_threadsaf=
e
> is
> +        # recommended to get back to the main loop.
> +        self.loop.call_soon_threadsafe(self.child_exited, pid, status)
> +
> +    async def main_loop(self):
> +        bb.utils.nonblockingfd(self.pipeinfd)
> +        await read_messages(self.pipeinfd, {
> +            b"event": self.handle_event,
> +        })
> +        os.close(self.pipeinfd)
> +        await self.done_event.wait()
> +
> +    async def handle_event(self, data):
> +        self.writer.write(b"<event>")
> +        self.writer.write(data)
> +        self.writer.write(b"</event>")
> +        await self.writer.drain()
> +
> +    def child_exited(self, pid, status):
>          try:
> -            worker_queue_int =3D worker_queue_int + worker_queue.get(Tru=
e,
> 1)
> -        except queue.Empty:
> -            pass
> -        while (worker_queue_int or not worker_queue.empty()):
> +            if pid !=3D self.pid:
> +                return
> +
> +            workerlog_write("Exit code of %d for pid %d (fd %d)\n" %
> (status, pid, self.pipeinfd))
> +
> +            asyncio.get_child_watcher().remove_child_handler(self.pid)
> +
> +            if os.WIFEXITED(status):
> +                status =3D os.WEXITSTATUS(status)
> +            elif os.WIFSIGNALED(status):
> +                # Per shell conventions for $?, when a process exits due
> to
> +                # a signal, we return an exit code of 128 + SIGNUM
> +                status =3D 128 + os.WTERMSIG(status)
> +
> +            self.writer.write(b"<exitcode>")
> +            self.writer.write(pickle.dumps((self.task, status)))
> +            self.writer.write(b"</exitcode>")
> +
> +            self.done_event.set()
> +        except Exception as e:
> +            workerlog_write("%s\n%s\n" % (traceback.format_exc(), e))
> +            raise e
> +
> +    def close(self):
> +        if not self.done_event.is_set():
>              try:
> -                (_, ready, _) =3D select.select([], [worker_pipe], [], 1=
)
> -                if not worker_queue.empty():
> -                    worker_queue_int =3D worker_queue_int +
> worker_queue.get()
> -                written =3D os.write(worker_pipe, worker_queue_int)
> -                worker_queue_int =3D worker_queue_int[written:]
> -            except (IOError, OSError) as e:
> -                if e.errno !=3D errno.EAGAIN and e.errno !=3D errno.EPIP=
E:
> -                    raise
> -        if worker_thread_exit and worker_queue.empty() and not
> worker_queue_int:
> -            return
> +                os.kill(-self.pid, signal.SIGTERM)
> +            except OSError:
> +                pass
> +
> +
> +class MainHandler(object):
> +    def __init__(self, writer):
> +        self.writer =3D writer
> +        self.cookercfg =3D None
> +        self.databuilder =3D None
> +        self.data =3D None
> +        self.extraconfigdata =3D None
> +        self.children =3D []
> +        self.child_tasks =3D []
>=20
> -worker_thread =3D Thread(target=3Dworker_flush, args=3D(worker_queue,))
> -worker_thread.start()
> +    async def main_loop(self):
> +        loop =3D asyncio.get_running_loop()
> +        fd =3D sys.stdin.fileno()
> +        bb.utils.nonblockingfd(fd)
>=20
> -def worker_child_fire(event, d):
> -    global worker_pipe
> -    global worker_pipe_lock
> +        loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
> +        loop.add_signal_handler(signal.SIGHUP, self.signal_handler)
>=20
> -    data =3D b"<event>" + pickle.dumps(event) + b"</event>"
> -    try:
> -        worker_pipe_lock.acquire()
> -        while(len(data)):
> -            written =3D worker_pipe.write(data)
> -            data =3D data[written:]
> -        worker_pipe_lock.release()
> -    except IOError:
> -        sigterm_handler(None, None)
> -        raise
> +        try:
> +            await read_messages(fd, {
> +                b"cookerconfig": self.handle_cookercfg,
> +                b"extraconfigdata": self.handle_extraconfigdata,
> +                b"workerdata": self.handle_workerdata,
> +                b"newtaskhashes": self.handle_newtaskhashes,
> +                b"runtask": self.handle_runtask,
> +                b"finishnow": self.handle_finishnow,
> +                b"ping": self.handle_ping,
> +                b"quit": self.handle_quit,
> +                }
> +            )
> +        finally:
> +            loop.remove_signal_handler(signal.SIGTERM)
> +            loop.remove_signal_handler(signal.SIGHUP)
> +
> +    def signal_handler(self, signum, stackframe):
> +        loop =3D asyncio.get_running_loop()
> +
> +        if signum =3D=3D signal.SIGTERM:
> +            bb.warn("Worker received SIGTERM, shutting down...")
> +        elif signum =3D=3D signal.SIGHUP:
> +            bb.warn("Worker received SIGHUP, shutting down...")
> +
> +        self.handle_finishnow(None)
> +        loop.remove_signal_handler(signal.SIGTERM)
> +        os.kill(os.getpid(), signal.SIGTERM)
> +
> +    async def handle_cookercfg(self, data):
> +        self.cookercfg =3D pickle.loads(data)
> +        self.databuilder =3D
> bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=3DTrue)
> +        self.databuilder.parseBaseConfiguration()
> +        self.data =3D self.databuilder.data
> +
> +    async def handle_extraconfigdata(self, data):
> +        self.extraconfigdata =3D pickle.loads(data)
> +
> +    async def handle_workerdata(self, data):
> +        self.workerdata =3D pickle.loads(data)
> +        bb.build.verboseShellLogging =3D
> self.workerdata["build_verbose_shell"]
> +        bb.build.verboseStdoutLogging =3D
> self.workerdata["build_verbose_stdout"]
> +        bb.msg.loggerDefaultLogLevel =3D self.workerdata["logdefaultleve=
l"]
> +        bb.msg.loggerDefaultDomains =3D self.workerdata["logdefaultdomai=
n"]
> +        for mc in self.databuilder.mcdata:
> +            self.databuilder.mcdata[mc].setVar("PRSERV_HOST",
> self.workerdata["prhost"])
> +            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE",
> self.workerdata["hashservaddr"])
> +
> +    async def handle_newtaskhashes(self, data):
> +        self.workerdata["newhashes"] =3D pickle.loads(data)
> +
> +    async def handle_ping(self, _):
> +        logger.warning("Pong from bitbake-worker!")
> +
> +    async def handle_quit(self, data):
> +        global normalexit
> +        normalexit =3D True
> +        sys.exit(0)
> +
> +    async def run_child(self, child):
> +        await child.main_loop()
> +        self.children.remove(child)
> +        self.child_tasks.remove(asyncio.current_task())
> +
> +    async def handle_runtask(self, data):
> +        fn, task, taskname, taskhash, unihash, quieterrors, appends,
> taskdepdata, dry_run_exec =3D pickle.loads(data)
> +        workerlog_write("Handling runtask %s %s %s\n" % (task, fn,
> taskname))
> +
> +        pid, pipeinfd, pipeoutfd =3D fork_off_task(self.cookercfg,
> self.data, self.databuilder, self.workerdata, fn, task, taskname,
> taskhash, unihash, appends, taskdepdata, self.extraconfigdata,
> quieterrors, dry_run_exec)
> +
> +        child =3D ChildHandler(self.writer, task, pid, pipeinfd, pipeout=
fd)
> +        self.children.append(child)
> +
> +        t =3D asyncio.ensure_future(self.run_child(child))
> +        self.child_tasks.append(t)
> +
> +    async def handle_finishnow(self, _=3DNone):
> +        for c in self.children:
> +            c.close()
> +
> +        workerlog_write("Waiting for %d child tasks: %s\n" %
> (len(self.child_tasks),
> +            " ".join(str(c.pid) for c in self.children)))
> +
> +        # Wait for all outstanding children to exit
> +        await asyncio.gather(*self.child_tasks)
> +
> +async def main():
> +    writer =3D await connect_stdout()
> +    worker_queue =3D []
> +
> +    def worker_fire(event, d):
> +        nonlocal worker_queue
> +
> +        async def flush_worker_queue():
> +            nonlocal writer
> +            nonlocal worker_queue
> +
> +            if worker_queue:
> +                for m in worker_queue:
> +                    writer.write(m)
> +                worker_queue =3D []
> +                await writer.drain()
> +
> +        # To ensure the messages are sent out in the order they are
> received,
> +        # put them in a list then schedule a task to write them out
> +        data =3D b"<event>" + pickle.dumps(event) + b"</event>"
> +        worker_queue.append(data)
> +        asyncio.ensure_future(flush_worker_queue())
>=20
> -bb.event.worker_fire =3D worker_fire
> +    bb.event.worker_fire =3D worker_fire
> +
> +    handler =3D MainHandler(writer)
> +
> +    await asyncio.gather(handler.main_loop())
> +
> +normalexit =3D False
>=20
>  lf =3D None
>  #lf =3D open("/tmp/workercommandlog", "w+")
>  def workerlog_write(msg):
> +    global lf
>      if lf:
>          lf.write(msg)
>          lf.flush()
>=20
> +
>  def sigterm_handler(signum, frame):
>      signal.signal(signal.SIGTERM, signal.SIG_DFL)
>      os.killpg(0, signal.SIGTERM)
> @@ -191,9 +387,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,
> fn, task, taskname, taskha
>      sys.stderr.flush()
>=20
>      try:
> -        pipein, pipeout =3D os.pipe()
> -        pipein =3D os.fdopen(pipein, 'rb', 4096)
> -        pipeout =3D os.fdopen(pipeout, 'wb', 0)
> +        pipeinfd, pipeoutfd =3D os.pipe()
>          pid =3D os.fork()
>      except OSError as e:
>          logger.critical("fork failed: %d (%s)" % (e.errno, e.strerror))
> @@ -201,18 +395,30 @@ def fork_off_task(cfg, data, databuilder,
> workerdata, fn, task, taskname, taskha
>=20
>      if pid =3D=3D 0:
>          def child():
> -            global worker_pipe
> -            global worker_pipe_lock
> -            pipein.close()
> +            os.close(pipeinfd)
>=20
>              bb.utils.signal_on_parent_exit("SIGTERM")
>=20
> +            pipeout =3D os.fdopen(pipeoutfd, 'wb', 0)
> +            pipelock =3D Lock()
> +            def worker_child_fire(event, d):
> +                nonlocal pipeout
> +                nonlocal pipelock
> +
> +                data =3D b"<event>" + pickle.dumps(event) + b"</event>"
> +                try:
> +                    with pipelock:
> +                        while(len(data)):
> +                            written =3D pipeout.write(data)
> +                            data =3D data[written:]
> +                except IOError:
> +                    sigterm_handler(None, None)
> +                    raise
> +
>              # Save out the PID so that the event can include it the
>              # events
>              bb.event.worker_pid =3D os.getpid()
>              bb.event.worker_fire =3D worker_child_fire
> -            worker_pipe =3D pipeout
> -            worker_pipe_lock =3D Lock()
>=20
>              # Make the child the process group leader and ensure no
>              # child process will be controlled by the current terminal
> @@ -315,225 +521,33 @@ def fork_off_task(cfg, data, databuilder,
> workerdata, fn, task, taskname, taskha
>              else:
>                  os.environ[key] =3D value
>=20
> -    return pid, pipein, pipeout
> -
> -class runQueueWorkerPipe():
> -    """
> -    Abstraction for a pipe between a worker thread and the worker server
> -    """
> -    def __init__(self, pipein, pipeout):
> -        self.input =3D pipein
> -        if pipeout:
> -            pipeout.close()
> -        bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> -
> -    def read(self):
> -        start =3D len(self.queue)
> -        try:
> -            self.queue =3D self.queue + (self.input.read(102400) or b"")
> -        except (OSError, IOError) as e:
> -            if e.errno !=3D errno.EAGAIN:
> -                raise
> -
> -        end =3D len(self.queue)
> -        index =3D self.queue.find(b"</event>")
> -        while index !=3D -1:
> -            msg =3D self.queue[:index+8]
> -            assert msg.startswith(b"<event>") and msg.count(b"<event>")
> =3D=3D 1
> -            worker_fire_prepickled(msg)
> -            self.queue =3D self.queue[index+8:]
> -            index =3D self.queue.find(b"</event>")
> -        return (end > start)
> -
> -    def close(self):
> -        while self.read():
> -            continue
> -        if len(self.queue) > 0:
> -            print("Warning, worker child left partial message: %s" %
> self.queue)
> -        self.input.close()
> -
> -normalexit =3D False
> +    return pid, pipeinfd, pipeoutfd
>=20
> -class BitbakeWorker(object):
> -    def __init__(self, din):
> -        self.input =3D din
> -        bb.utils.nonblockingfd(self.input)
> -        self.queue =3D b""
> -        self.cookercfg =3D None
> -        self.databuilder =3D None
> -        self.data =3D None
> -        self.extraconfigdata =3D None
> -        self.build_pids =3D {}
> -        self.build_pipes =3D {}
> -
> -        signal.signal(signal.SIGTERM, self.sigterm_exception)
> -        # Let SIGHUP exit as SIGTERM
> -        signal.signal(signal.SIGHUP, self.sigterm_exception)
> -        if "beef" in sys.argv[1]:
> -            bb.utils.set_process_name("Worker (Fakeroot)")
> -        else:
> -            bb.utils.set_process_name("Worker")
> -
> -    def sigterm_exception(self, signum, stackframe):
> -        if signum =3D=3D signal.SIGTERM:
> -            bb.warn("Worker received SIGTERM, shutting down...")
> -        elif signum =3D=3D signal.SIGHUP:
> -            bb.warn("Worker received SIGHUP, shutting down...")
> -        self.handle_finishnow(None)
> -        signal.signal(signal.SIGTERM, signal.SIG_DFL)
> -        os.kill(os.getpid(), signal.SIGTERM)
> -
> -    def serve(self):
> -        while True:
> -            (ready, _, _) =3D select.select([self.input] + [i.input for =
i
> in self.build_pipes.values()], [] , [], 1)
> -            if self.input in ready:
> -                try:
> -                    r =3D self.input.read()
> -                    if len(r) =3D=3D 0:
> -                        # EOF on pipe, server must have terminated
> -                        self.sigterm_exception(signal.SIGTERM, None)
> -                    self.queue =3D self.queue + r
> -                except (OSError, IOError):
> -                    pass
> -            if len(self.queue):
> -                self.handle_item(b"cookerconfig", self.handle_cookercfg)
> -                self.handle_item(b"extraconfigdata",
> self.handle_extraconfigdata)
> -                self.handle_item(b"workerdata", self.handle_workerdata)
> -                self.handle_item(b"newtaskhashes",
> self.handle_newtaskhashes)
> -                self.handle_item(b"runtask", self.handle_runtask)
> -                self.handle_item(b"finishnow", self.handle_finishnow)
> -                self.handle_item(b"ping", self.handle_ping)
> -                self.handle_item(b"quit", self.handle_quit)
> -
> -            for pipe in self.build_pipes:
> -                if self.build_pipes[pipe].input in ready:
> -                    self.build_pipes[pipe].read()
> -            if len(self.build_pids):
> -                while self.process_waitpid():
> -                    continue
> -
> -
> -    def handle_item(self, item, func):
> -        if self.queue.startswith(b"<" + item + b">"):
> -            index =3D self.queue.find(b"</" + item + b">")
> -            while index !=3D -1:
> -                try:
> -                    func(self.queue[(len(item) + 2):index])
> -                except pickle.UnpicklingError:
> -                    workerlog_write("Unable to unpickle data: %s\n" %
> ":".join("{:02x}".format(c) for c in self.queue))
> -                    raise
> -                self.queue =3D self.queue[(index + len(item) + 3):]
> -                index =3D self.queue.find(b"</" + item + b">")
> -
> -    def handle_cookercfg(self, data):
> -        self.cookercfg =3D pickle.loads(data)
> -        self.databuilder =3D
> bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=3DTrue)
> -        self.databuilder.parseBaseConfiguration()
> -        self.data =3D self.databuilder.data
> -
> -    def handle_extraconfigdata(self, data):
> -        self.extraconfigdata =3D pickle.loads(data)
> -
> -    def handle_workerdata(self, data):
> -        self.workerdata =3D pickle.loads(data)
> -        bb.build.verboseShellLogging =3D
> self.workerdata["build_verbose_shell"]
> -        bb.build.verboseStdoutLogging =3D
> self.workerdata["build_verbose_stdout"]
> -        bb.msg.loggerDefaultLogLevel =3D self.workerdata["logdefaultleve=
l"]
> -        bb.msg.loggerDefaultDomains =3D self.workerdata["logdefaultdomai=
n"]
> -        for mc in self.databuilder.mcdata:
> -            self.databuilder.mcdata[mc].setVar("PRSERV_HOST",
> self.workerdata["prhost"])
> -            self.databuilder.mcdata[mc].setVar("BB_HASHSERVE",
> self.workerdata["hashservaddr"])
> -
> -    def handle_newtaskhashes(self, data):
> -        self.workerdata["newhashes"] =3D pickle.loads(data)
> -
> -    def handle_ping(self, _):
> -        workerlog_write("Handling ping\n")
> -
> -        logger.warning("Pong from bitbake-worker!")
> -
> -    def handle_quit(self, data):
> -        workerlog_write("Handling quit\n")
> -
> -        global normalexit
> -        normalexit =3D True
> -        sys.exit(0)
> -
> -    def handle_runtask(self, data):
> -        fn, task, taskname, taskhash, unihash, quieterrors, appends,
> taskdepdata, dry_run_exec =3D pickle.loads(data)
> -        workerlog_write("Handling runtask %s %s %s\n" % (task, fn,
> taskname))
> -
> -        pid, pipein, pipeout =3D fork_off_task(self.cookercfg, self.data=
,
> self.databuilder, self.workerdata, fn, task, taskname, taskhash, unihash,
> appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
> -
> -        self.build_pids[pid] =3D task
> -        self.build_pipes[pid] =3D runQueueWorkerPipe(pipein, pipeout)
> -
> -    def process_waitpid(self):
> -        """
> -        Return none is there are no processes awaiting result collection=
,
> otherwise
> -        collect the process exit codes and close the information pipe.
> -        """
> -        try:
> -            pid, status =3D os.waitpid(-1, os.WNOHANG)
> -            if pid =3D=3D 0 or os.WIFSTOPPED(status):
> -                return False
> -        except OSError:
> -            return False
> -
> -        workerlog_write("Exit code of %s for pid %s\n" % (status, pid))
> -
> -        if os.WIFEXITED(status):
> -            status =3D os.WEXITSTATUS(status)
> -        elif os.WIFSIGNALED(status):
> -            # Per shell conventions for $?, when a process exits due to
> -            # a signal, we return an exit code of 128 + SIGNUM
> -            status =3D 128 + os.WTERMSIG(status)
> -
> -        task =3D self.build_pids[pid]
> -        del self.build_pids[pid]
> -
> -        self.build_pipes[pid].close()
> -        del self.build_pipes[pid]
> -
> -        worker_fire_prepickled(b"<exitcode>" + pickle.dumps((task,
> status)) + b"</exitcode>")
> -
> -        return True
> +try:
> +    if "beef" in sys.argv[1]:
> +        bb.utils.set_process_name("Worker (Fakeroot)")
> +    else:
> +        bb.utils.set_process_name("Worker")
>=20
> -    def handle_finishnow(self, _):
> -        if self.build_pids:
> -            logger.info("Sending SIGTERM to remaining %s tasks",
> len(self.build_pids))
> -            for k, v in iter(self.build_pids.items()):
> -                try:
> -                    os.kill(-k, signal.SIGTERM)
> -                    os.waitpid(-1, 0)
> -                except:
> -                    pass
> -        for pipe in self.build_pipes:
> -            self.build_pipes[pipe].read()
> +    loop =3D asyncio.get_event_loop()
>=20
> -try:
> -    worker =3D BitbakeWorker(os.fdopen(sys.stdin.fileno(), 'rb'))
>      if not profiling:
> -        worker.serve()
> +        loop.run_until_complete(main())
>      else:
>          profname =3D "profile-worker.log"
>          prof =3D profile.Profile()
>          try:
> -            profile.Profile.runcall(prof, worker.serve)
> +            profile.Profile.runcall(prof, loop.run_until_complete,
> main())
>          finally:
>              prof.dump_stats(profname)
>              bb.utils.process_profilelog(profname)
> -except BaseException as e:
> +except Exception as e:
> +    workerlog_write("%s\n%s\n" % (traceback.format_exc(), e))
>      if not normalexit:
> -        import traceback
>          sys.stderr.write(traceback.format_exc())
>          sys.stderr.write(str(e))
> -finally:
> -    worker_thread_exit =3D True
> -    worker_thread.join()
>=20
> -workerlog_write("exiting")
> +workerlog_write("exiting\n")
>  if not normalexit:
>      sys.exit(1)
>  sys.exit(0)
> --
> 2.33.0


