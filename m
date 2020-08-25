Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web10.618.1598375995252798983
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 10:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=cDvoy9VB;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id q14so11095519ilj.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H0CjF7nq0Gl88wLN1tVVGapmy8Z85huHCTw8FNOxK2I=;
        b=cDvoy9VBRrcsb9ezgb2rVWmeC8O84/ROCvN9sZss3gyhF8CfvEMBsfnd8Awc/I1gcK
         zVOdT3YEe9uGYdE+WTKykQgsvK3GCE48fo/0L3hZl8yaip1M2XL0lJhIopOIWxrMjTjY
         g7E4YAyBn+HIAUveEVvMJNV8EqcgBjUoBevUtldGTJFA93GKdAIp97SKv0s4vB9AxfCE
         qiI04bXKldLKY0ZcyFvbtmwdPxyLZMobPuA1HJr5EpXS54slNgu4278zp1KMX9iXl4ry
         E76BCpTFaZC3C63o5er0OmH3ECD4qD2HeRnnW5VgVRBVrDs52M6d8NbbN4nayYgrm0Uk
         dhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H0CjF7nq0Gl88wLN1tVVGapmy8Z85huHCTw8FNOxK2I=;
        b=rDaWLd+8qp1zGA4XJkGZG2uzlFYTkjzNCAwrCvKfWch5ornzjjwQF3cM+WADEqIu/L
         OdlmqCJeQMeXdUMI2QnGrsGkIckKAXEvRHqlxBnmTGmF/j/IgtM+T6tlDtpsKWA+6TRL
         coUpih2NDdCmq4g8jJi5tBLlunKnu1CqOhHj5P1NjXUMzNCYASet1nG2SqUidyeCKT0K
         SRkThgbNdpMpsriR1EPceJEbA1ptM/CXG0Prvhf4+JkejtzTDisse+lcW2uPoqFEomQF
         zQtv9r+fQK80C3pQMDS45dIHmZrTQ1cOTneHc3AoPfiamXYaPPhb4X7jbF8F1BAAvoMK
         2HDw==
X-Gm-Message-State: AOAM530vv7PsHW78ZtgqGg2a0HGlKQf75tnZD3YgrlZa9JtmYk7rzGFQ
	KZKmFIRTipsLCH8v8zRN6+9d3Ro6J/c=
X-Google-Smtp-Source: ABdhPJzZy8+NQl4h3ijBjxiy2kr8qBp5BGWQFd3nBl7pmyuEBvEoAhcjrXcgUx1p4uJxls9Qet2p2A==
X-Received: by 2002:a05:6e02:e48:: with SMTP id l8mr10355977ilk.204.1598375993849;
        Tue, 25 Aug 2020 10:19:53 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:5db1:6b17:9d39:142? ([2605:a601:ac3d:c100:5db1:6b17:9d39:142])
        by smtp.gmail.com with ESMTPSA id s87sm9639391ili.73.2020.08.25.10.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:19:52 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/10] server/process: Add bitbake-server and exec() a new server process
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
 <20200824165331.1373725-10-richard.purdie@linuxfoundation.org>
 <CAJdd5GbXLN5vJRnkN7r_q2WQ_6Chzv+H-=QemyK-NLz4bHD2eA@mail.gmail.com>
 <62208925fac6619c9153f8a3c2c08a2acb86ee20.camel@linuxfoundation.org>
Message-ID: <e280c761-ea16-8c03-2dd9-68dc2c489f80@gmail.com>
Date: Tue, 25 Aug 2020 12:19:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62208925fac6619c9153f8a3c2c08a2acb86ee20.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US


On 8/25/20 12:06 PM, Richard Purdie wrote:
> On Tue, 2020-08-25 at 11:06 -0500, Joshua Watt wrote:
>> On Mon, Aug 24, 2020 at 11:53 AM Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>>> Trying to have a new python process forked off an original doesn't work
>>> out well and ends up having race issues. To avoid this, exec() a new
>>> bitbake server process. This starts with a fresh python interpreter
>>> and resolves various atexit and other multiprocessing issues once
>>> and for all.
>>>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> ---
>>>   lib/bb/server/process.py | 92 +++++++++++++++++++++++-----------------
>>>   1 file changed, 53 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
>>> index 915651084e..d248570cd2 100644
>>> --- a/lib/bb/server/process.py
>>> +++ b/lib/bb/server/process.py
>>> @@ -38,7 +38,7 @@ class ProcessServer():
>>>       profile_filename = "profile.log"
>>>       profile_processed_filename = "profile.log.processed"
>>>
>>> -    def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
>>> +    def __init__(self, lock, lockname, sock, sockname, server_timeout, xmlrpcinterface):
>>>           self.command_channel = False
>>>           self.command_channel_reply = False
>>>           self.quit = False
>>> @@ -54,6 +54,7 @@ class ProcessServer():
>>>           self._idlefuns = {}
>>>
>>>           self.bitbake_lock = lock
>>> +        self.bitbake_lock_name = lockname
>>>           self.sock = sock
>>>           self.sockname = sockname
>>>
>>> @@ -259,7 +260,7 @@ class ProcessServer():
>>>
>>>           # Finally release the lockfile but warn about other processes holding it open
>>>           lock = self.bitbake_lock
>>> -        lockfile = lock.name
>>> +        lockfile = self.bitbake_lock_name
>>>           lock.close()
>>>           lock = None
>>>
>>> @@ -393,9 +394,10 @@ class BitBakeProcessServerConnection(object):
>>>           self.connection.recv.close()
>>>           return
>>>
>>> +start_log_format = '--- Starting bitbake server pid %s at %s ---'
>>> +start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
>>> +
>>>   class BitBakeServer(object):
>>> -    start_log_format = '--- Starting bitbake server pid %s at %s ---'
>>> -    start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
>>>
>>>       def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
>>>
>>> @@ -429,7 +431,7 @@ class BitBakeServer(object):
>>>               ready.close()
>>>               bb.error("Unable to start bitbake server (%s)" % str(r))
>>>               if os.path.exists(logfile):
>>> -                logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
>>> +                logstart_re = re.compile(start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
>>>                   started = False
>>>                   lines = []
>>>                   lastlines = []
>>> @@ -441,7 +443,7 @@ class BitBakeServer(object):
>>>                               lastlines.append(line)
>>>                               res = logstart_re.match(line.rstrip())
>>>                               if res:
>>> -                                ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
>>> +                                ldatetime = datetime.datetime.strptime(res.group(2), start_log_datetime_format)
>>>                                   if ldatetime >= startdatetime:
>>>                                       started = True
>>>                                       lines.append(line)
>>> @@ -462,42 +464,54 @@ class BitBakeServer(object):
>>>           ready.close()
>>>
>>>       def _startServer(self):
>>> -        print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
>>> -        sys.stdout.flush()
>>> +        os.close(self.readypipe)
>>> +        os.set_inheritable(self.bitbake_lock.fileno(), True)
>>> +        os.set_inheritable(self.readypipein, True)
>>> +        os.execlp("bitbake-server", "bitbake-server", "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
>> You may want to do:
>>
>>   os.execl(sys.executable, sys.executable, "bitbake-server", ....)
>>
>> This ensures that the same python interpreter is used for the server
>> and UI front end.
> Yes, good point, although leaving arg0 as bitbake-server is probably
> helpful for debugging so you can see the server process in a process
> listing?

Ya, that's seems fine:

  os.execl(sys.executable, "bitbake-server", bitbake_server_path, ....)

looks like it would work

>
> I had to change the code slightly in master-next to use execl() with
> "../../../bitbake-server" based upon __file__ as it would break in
> cases where we've messed around with PATH.
>
> Cheers,
>
> Richard
>
>
