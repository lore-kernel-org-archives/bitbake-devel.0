Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.16957.1598371586859308728
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 09:06:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=fRqA0vzt;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id u18so2989228wmc.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnJ0WFpvzwXc4SWeZSRjGNJQltLBUtZa3ejWrfNx7YI=;
        b=fRqA0vztCX/2wDfRmoAxA7yHfnWt+9/NPBXXNeehLG/7OGzH9CbsNPL8EdJpC8CgFG
         5HkNH7F0ZvW4SlIrLhIqRcSoYWKD6HpSKDTAGoRXU7cUfv9+Z4TzjySVEZuVeqQAfRx9
         MWcJdVbd5jWnj3S3kSupuR1mOHnz8mx1WDkg2nj+uZNDgALkVxhxtwUClO9nL+LNfzK/
         d29I3ZQX4qnNkyUV+Jg/lKyvNA3G5YmJrzxiObGjz83fuNVBCaNFvhLBF+WloStYzTKa
         rC8vXVS9uSVoxCViOxzwEu54GUVIiJmVeB3iIcaZeKX4bX6W2L8ZLEaLEQiI/i+aeeBq
         3SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnJ0WFpvzwXc4SWeZSRjGNJQltLBUtZa3ejWrfNx7YI=;
        b=e6Wz78K15Kfne0uM5bHR5ZYjLaIouRUUHZ8POKoZNwb5T/PnU6Hjzm3UEtEM0YwoVe
         PO+Cxk3gCKrR4blKYIkf39ViMPxFxnU/mukJ9LjJDpHqUS03qFvIjeruiWqpOL0PuI02
         ESA4cKWebmWakfMWVImJXB0L/dJX2UaNFX8zDt45t3DWMWnQteNy77rzzVjIekb5A/Hr
         LtV2rzgD2+WLmpAtwQlMESuIU135IyS0AXJ29p7zz5U/wEAiW2bzLZJeUqKxgoP5i2Pi
         nXoC23PcglXh9F0gCLtGyQXHf3bxPhQDqPgmSzHqjYx3zZkoMRvEdMBCYL8KjjYXqX9C
         MdcA==
X-Gm-Message-State: AOAM533xKo67aPR85/TRWo3BfpleRnyi3lcLQmOeck7jmK/sJBIpFNAK
	UCUVJ8LjgC/pWaLeMxaEz0G3joQcycJyeh3io8Y=
X-Google-Smtp-Source: ABdhPJx2mUCDTPMIGHGfYxbG6MgMVKo2hnblP94hoe/7JMOo3nYLqF+CrO9x+qPI/nRr3CJG8n9MhxXfeM+oMg+v94M=
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr2898842wmj.56.1598371585165;
 Tue, 25 Aug 2020 09:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org> <20200824165331.1373725-10-richard.purdie@linuxfoundation.org>
In-Reply-To: <20200824165331.1373725-10-richard.purdie@linuxfoundation.org>
From: "Joshua Watt" <JPEWhacker@gmail.com>
Date: Tue, 25 Aug 2020 11:06:12 -0500
Message-ID: <CAJdd5GbXLN5vJRnkN7r_q2WQ_6Chzv+H-=QemyK-NLz4bHD2eA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/10] server/process: Add bitbake-server and exec() a new server process
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 24, 2020 at 11:53 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> Trying to have a new python process forked off an original doesn't work
> out well and ends up having race issues. To avoid this, exec() a new
> bitbake server process. This starts with a fresh python interpreter
> and resolves various atexit and other multiprocessing issues once
> and for all.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/server/process.py | 92 +++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 39 deletions(-)
>
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 915651084e..d248570cd2 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -38,7 +38,7 @@ class ProcessServer():
>      profile_filename = "profile.log"
>      profile_processed_filename = "profile.log.processed"
>
> -    def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
> +    def __init__(self, lock, lockname, sock, sockname, server_timeout, xmlrpcinterface):
>          self.command_channel = False
>          self.command_channel_reply = False
>          self.quit = False
> @@ -54,6 +54,7 @@ class ProcessServer():
>          self._idlefuns = {}
>
>          self.bitbake_lock = lock
> +        self.bitbake_lock_name = lockname
>          self.sock = sock
>          self.sockname = sockname
>
> @@ -259,7 +260,7 @@ class ProcessServer():
>
>          # Finally release the lockfile but warn about other processes holding it open
>          lock = self.bitbake_lock
> -        lockfile = lock.name
> +        lockfile = self.bitbake_lock_name
>          lock.close()
>          lock = None
>
> @@ -393,9 +394,10 @@ class BitBakeProcessServerConnection(object):
>          self.connection.recv.close()
>          return
>
> +start_log_format = '--- Starting bitbake server pid %s at %s ---'
> +start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
> +
>  class BitBakeServer(object):
> -    start_log_format = '--- Starting bitbake server pid %s at %s ---'
> -    start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
>
>      def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
>
> @@ -429,7 +431,7 @@ class BitBakeServer(object):
>              ready.close()
>              bb.error("Unable to start bitbake server (%s)" % str(r))
>              if os.path.exists(logfile):
> -                logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
> +                logstart_re = re.compile(start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
>                  started = False
>                  lines = []
>                  lastlines = []
> @@ -441,7 +443,7 @@ class BitBakeServer(object):
>                              lastlines.append(line)
>                              res = logstart_re.match(line.rstrip())
>                              if res:
> -                                ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
> +                                ldatetime = datetime.datetime.strptime(res.group(2), start_log_datetime_format)
>                                  if ldatetime >= startdatetime:
>                                      started = True
>                                      lines.append(line)
> @@ -462,42 +464,54 @@ class BitBakeServer(object):
>          ready.close()
>
>      def _startServer(self):
> -        print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
> -        sys.stdout.flush()
> +        os.close(self.readypipe)
> +        os.set_inheritable(self.bitbake_lock.fileno(), True)
> +        os.set_inheritable(self.readypipein, True)
> +        os.execlp("bitbake-server", "bitbake-server", "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))

You may want to do:

 os.execl(sys.executable, sys.executable, "bitbake-server", ....)

This ensures that the same python interpreter is used for the server
and UI front end.

>
> -        try:
> -            # Create server control socket
> -            if os.path.exists(self.sockname):
> -                os.unlink(self.sockname)
> +def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface):
>
> -            sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> -            # AF_UNIX has path length issues so chdir here to workaround
> -            cwd = os.getcwd()
> -            try:
> -                os.chdir(os.path.dirname(self.sockname))
> -                sock.bind(os.path.basename(self.sockname))
> -            finally:
> -                os.chdir(cwd)
> -            sock.listen(1)
> -
> -            server = ProcessServer(self.bitbake_lock, sock, self.sockname, self.server_timeout, self.xmlrpcinterface)
> -            os.close(self.readypipe)
> -            writer = ConnectionWriter(self.readypipein)
> -            try:
> -                self.cooker = bb.cooker.BBCooker(self.featureset, server.register_idle_function)
> -            except bb.BBHandledException:
> -                return None
> -            writer.send("r")
> -            writer.close()
> -            server.cooker = self.cooker
> -            print("Started bitbake server pid %d" % os.getpid())
> -            sys.stdout.flush()
> -
> -            server.run()
> +    import bb.cookerdata
> +    import bb.cooker
> +
> +    print(start_log_format % (os.getpid(), datetime.datetime.now().strftime(start_log_datetime_format)))
> +    sys.stdout.flush()
> +
> +    try:
> +        bitbake_lock = os.fdopen(lockfd, "w")
> +
> +        # Create server control socket
> +        if os.path.exists(sockname):
> +            os.unlink(sockname)
> +
> +        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +        # AF_UNIX has path length issues so chdir here to workaround
> +        cwd = os.getcwd()
> +        try:
> +            os.chdir(os.path.dirname(sockname))
> +            sock.bind(os.path.basename(sockname))
>          finally:
> -            # Flush any ,essages/errors to the logfile before exit
> -            sys.stdout.flush()
> -            sys.stderr.flush()
> +            os.chdir(cwd)
> +        sock.listen(1)
> +
> +        server = ProcessServer(bitbake_lock, lockname, sock, sockname, server_timeout, xmlrpcinterface)
> +        writer = ConnectionWriter(readypipeinfd)
> +        try:
> +            featureset = []
> +            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function)
> +        except bb.BBHandledException:
> +            return None
> +        writer.send("r")
> +        writer.close()
> +        server.cooker = cooker
> +        print("Started bitbake server pid %d" % os.getpid())
> +        sys.stdout.flush()
> +
> +        server.run()
> +    finally:
> +        # Flush any ,essages/errors to the logfile before exit
> +        sys.stdout.flush()
> +        sys.stderr.flush()
>
>  def connectProcessServer(sockname, featureset):
>      # Connect to socket
> --
> 2.25.1
>
> 
