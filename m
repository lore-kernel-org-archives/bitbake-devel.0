Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.354.1598375185486909072
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 10:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AzHbYA+C;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id a65so3220572wme.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2ludfj//keOk3508OIgAMdLjb3SssmaH8jawRkrg4+Y=;
        b=AzHbYA+CDwWtRc/u3Yq36/443iWAk3SpWslKgIV8fcdddeI5oNY1RreAsYT57C8/YR
         GzMelYidi/ErWM9wrKaOMiTXGFN/PQ7ZlhT/C5uncsH1PvLSViyu8SdumdXKZnECKfpd
         MkspYdiYpHWrUy40WUYsMHsqFGR7eJoP9iAR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2ludfj//keOk3508OIgAMdLjb3SssmaH8jawRkrg4+Y=;
        b=WJEccg9joRZguMILKdnTpN+xSydgLLFz7j3A80e6f+FjzAv5xVjtF9bm9zQfb8hq+E
         4ANTz/hID275hTe5ZHqb8oSFPqadplEtkfCJBNUPovkG6A+l7FEVm9z4IsgdpjalkGAb
         1ONi5DnXMYqtUTezdx6oMuvOLIzdIeT8z9kQa91pj+/I5Z+nTilfOKF7s4caBkirKZfG
         d25LhU7MUD/j9GYt/8H+RUAiBre2+Q1Vg+Y8iyF9waDe6yZsK2FV00JFBrrvxfSK2Vkv
         SJTaasVsQRAFDh1/y7ESGcUXLhE8wkGKk7/BWlxjxnHx0k+gkrvWgxaSe4Cu+yeNMdty
         IEBw==
X-Gm-Message-State: AOAM530DPDMDwjFfDBJbgNhX03LGU8Rf3SAqFHZCvb05PCkoDEZgIL51
	aGRI3UC9/6p5NO48ewVfTTQ9eA==
X-Google-Smtp-Source: ABdhPJyfhYhxdrMre6Lz6tGBFlbeTqPO6VgqeCKP+6MGIhXyz/0Uqem9/d4oKRvbn+aOfes3ij5fDQ==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr3041547wmm.80.1598375183858;
        Tue, 25 Aug 2020 10:06:23 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id f2sm12112254wrj.54.2020.08.25.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:06:23 -0700 (PDT)
Message-ID: <62208925fac6619c9153f8a3c2c08a2acb86ee20.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 10/10] server/process: Add bitbake-server and exec() a new server process
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Aug 2020 18:06:22 +0100
In-Reply-To: <CAJdd5GbXLN5vJRnkN7r_q2WQ_6Chzv+H-=QemyK-NLz4bHD2eA@mail.gmail.com>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
	 <20200824165331.1373725-10-richard.purdie@linuxfoundation.org>
	 <CAJdd5GbXLN5vJRnkN7r_q2WQ_6Chzv+H-=QemyK-NLz4bHD2eA@mail.gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-08-25 at 11:06 -0500, Joshua Watt wrote:
> On Mon, Aug 24, 2020 at 11:53 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Trying to have a new python process forked off an original doesn't work
> > out well and ends up having race issues. To avoid this, exec() a new
> > bitbake server process. This starts with a fresh python interpreter
> > and resolves various atexit and other multiprocessing issues once
> > and for all.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/server/process.py | 92 +++++++++++++++++++++++-----------------
> >  1 file changed, 53 insertions(+), 39 deletions(-)
> > 
> > diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> > index 915651084e..d248570cd2 100644
> > --- a/lib/bb/server/process.py
> > +++ b/lib/bb/server/process.py
> > @@ -38,7 +38,7 @@ class ProcessServer():
> >      profile_filename = "profile.log"
> >      profile_processed_filename = "profile.log.processed"
> > 
> > -    def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
> > +    def __init__(self, lock, lockname, sock, sockname, server_timeout, xmlrpcinterface):
> >          self.command_channel = False
> >          self.command_channel_reply = False
> >          self.quit = False
> > @@ -54,6 +54,7 @@ class ProcessServer():
> >          self._idlefuns = {}
> > 
> >          self.bitbake_lock = lock
> > +        self.bitbake_lock_name = lockname
> >          self.sock = sock
> >          self.sockname = sockname
> > 
> > @@ -259,7 +260,7 @@ class ProcessServer():
> > 
> >          # Finally release the lockfile but warn about other processes holding it open
> >          lock = self.bitbake_lock
> > -        lockfile = lock.name
> > +        lockfile = self.bitbake_lock_name
> >          lock.close()
> >          lock = None
> > 
> > @@ -393,9 +394,10 @@ class BitBakeProcessServerConnection(object):
> >          self.connection.recv.close()
> >          return
> > 
> > +start_log_format = '--- Starting bitbake server pid %s at %s ---'
> > +start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
> > +
> >  class BitBakeServer(object):
> > -    start_log_format = '--- Starting bitbake server pid %s at %s ---'
> > -    start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
> > 
> >      def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
> > 
> > @@ -429,7 +431,7 @@ class BitBakeServer(object):
> >              ready.close()
> >              bb.error("Unable to start bitbake server (%s)" % str(r))
> >              if os.path.exists(logfile):
> > -                logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
> > +                logstart_re = re.compile(start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
> >                  started = False
> >                  lines = []
> >                  lastlines = []
> > @@ -441,7 +443,7 @@ class BitBakeServer(object):
> >                              lastlines.append(line)
> >                              res = logstart_re.match(line.rstrip())
> >                              if res:
> > -                                ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
> > +                                ldatetime = datetime.datetime.strptime(res.group(2), start_log_datetime_format)
> >                                  if ldatetime >= startdatetime:
> >                                      started = True
> >                                      lines.append(line)
> > @@ -462,42 +464,54 @@ class BitBakeServer(object):
> >          ready.close()
> > 
> >      def _startServer(self):
> > -        print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
> > -        sys.stdout.flush()
> > +        os.close(self.readypipe)
> > +        os.set_inheritable(self.bitbake_lock.fileno(), True)
> > +        os.set_inheritable(self.readypipein, True)
> > +        os.execlp("bitbake-server", "bitbake-server", "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
> 
> You may want to do:
> 
>  os.execl(sys.executable, sys.executable, "bitbake-server", ....)
> 
> This ensures that the same python interpreter is used for the server
> and UI front end.

Yes, good point, although leaving arg0 as bitbake-server is probably
helpful for debugging so you can see the server process in a process
listing?

I had to change the code slightly in master-next to use execl() with
"../../../bitbake-server" based upon __file__ as it would break in
cases where we've messed around with PATH.

Cheers,

Richard


