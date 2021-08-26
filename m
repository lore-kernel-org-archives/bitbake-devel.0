Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.32828.1629993769898158503
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Aug 2021 09:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Exx580QI;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id z10so5400618edb.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Aug 2021 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nG/NvHPsIIjKrCyH95KNj8CfxrujPUq5j7E2DvQOKxk=;
        b=Exx580QIUQhV9hFih4h7KG/qpu4wubumn6AIlGPjv5i91PSPPVdiVQSbkGg01zaSTy
         AHS9fSFc0rVL4bwIHK5znv5LhhuLAPqhTsbLqDPujRtPKhY+AM2986E95FscEY4QhEld
         Oj7xnpCSK5VPi1fqzYlGMixXxMWUdv713kUW37UjtKo+NOmL4YPqiDr5wMLyxyH+wJ1O
         GyW6fBNmn/dFM4GyvTn/IGR1aVkMzWoPlRBj0nH6QAQG0mNFHp5tGTknfzAwqlP7cnBJ
         sRNuSo3EvuHAeplRPer1qtzT1vQ0Z9ZRotLMaoev8dqnb/SRLjpqljZ71l6AHoFWpZT5
         cwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nG/NvHPsIIjKrCyH95KNj8CfxrujPUq5j7E2DvQOKxk=;
        b=W4gbs91XjAMpXlsvWIjNmYPptfkk/Gbh+Ix+GNRtqiYzScuKwgq/7RhXiJ70+uolDG
         rS+T4CyUW7xR+4w6+Pi63suJZk6i+PG9fi7zF5dXIywc2FKDKZiOhfSaRDnr47IYWmJL
         AOElPa41xAWuWvdtNPkmSGz9s+7/o72o1CYr0iQ8BTJ3C2OoNxGLdYgq/uLZdeqkJqDK
         AiTkUVir/SpaLcSBS1+1QN+dZcptdmKl9IMXQKgoVNaeJGmfPflpD3VL4IJPKdZRusDQ
         WudKxmGrNZUudQcVRs+HnsONpoMioY6E0dTqBY9dOVRK9CQii0MDO7TWssOggMywiSXz
         1+2g==
X-Gm-Message-State: AOAM532M37YZvpy4cjalho7X2+soWzg7IRJ6uUUGzWAxOWtDjClu9PAP
	NEZH+xOmHb23z++Nv/b4AiDnrE+R0fZRoh/JwJg=
X-Google-Smtp-Source: ABdhPJz9uQnwFQLGcKZQb27K58tcTUV6fM4zaxA3Qli7dl9aNc3ClltE/93IIg2AEgXTOxM/Qt9mqRsdK/EHWon2lOg=
X-Received: by 2002:a05:6402:c9:: with SMTP id i9mr4889138edu.76.1629993768158;
 Thu, 26 Aug 2021 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629388054.git.scott.murray@konsulko.com> <9a32587b89bb715e3614e15ab2695c0449d7ba26.1629388054.git.scott.murray@konsulko.com>
In-Reply-To: <9a32587b89bb715e3614e15ab2695c0449d7ba26.1629388054.git.scott.murray@konsulko.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Thu, 26 Aug 2021 18:02:37 +0200
Message-ID: <CA+chaQcuZp=-o8m96OnZ7KzRmFzUeuiQCS4b1zCKcuM4-SzbBw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v6 3/4] prserv: Replace XML RPC with modern asyncrpc implementation
To: Scott Murray <scott.murray@konsulko.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, Joshua Watt <JPEWhacker@gmail.com>, 
	Paul Barker <paul@pbarker.dev>
Content-Type: multipart/alternative; boundary="00000000000089882305ca787fc7"

--00000000000089882305ca787fc7
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 19, 2021 at 6:47 PM Scott Murray <scott.murray@konsulko.com>
wrote:

> From: Paul Barker <pbarker@konsulko.com>
>
> Update the prserv client and server classes to use the modern json and
> asyncio based RPC system implemented by the asyncrpc module.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> [updated for asyncrpc changes, client split to separate file]
> Signed-off-by: Scott Murray <scott.murray@konsulko.com>
>
> ....


> -    def export(self,version=None, pkgarch=None, checksum=None,
> colinfo=True):
> -        return self.connection.export(version, pkgarch, checksum, colinfo)
> +class PRServSingleton(object):
> +    def __init__(self, dbfile, logfile, host, port):
> +        self.dbfile = dbfile
> +        self.logfile = logfile
> +        self.host = host
> +        self.port = port
>
> -    def importone(self, version, pkgarch, checksum, value):
> -        return self.connection.importone(version, pkgarch, checksum,
> value)
> +    def start(self):
> +        self.prserv = PRServer(self.dbfile)
> +        self.prserv.start_tcp_server(self.host, self.port)
> +        self.process = self.prserv.serve_as_process()
>
> -    def getinfo(self):
> -        return self.host, self.port
> +        if not self.port:
> +            self.port = int(self.prserv.address.rsplit(':', 1)[1])
>
>
Hi,

I've tried this when running inside docker container and it failed with a
bit ugly exception:

bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
Traceback (most recent call last):
  File "/OE/nodistro/honister/bitbake/bin/bitbake", line 35, in <module>
    sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
  File "/OE/nodistro/honister/bitbake/lib/bb/main.py", line 385, in
bitbake_main
    return ui_module.main(server_connection.connection,
server_connection.events,
  File "/OE/nodistro/honister/bitbake/lib/bb/ui/knotty.py", line 397, in
main
    params.updateToServer(server, os.environ.copy())
  File "/OE/nodistro/honister/bitbake/lib/bb/cookerdata.py", line 75, in
updateToServer
    raise Exception("Unable to update the server configuration with local
parameters: %s" % error)
Exception: Unable to update the server configuration with local parameters:
Traceback (most recent call last):
  File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 90, in
runCommand
    result = command_method(self, commandline)
  File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 286, in
updateConfig
    command.cooker.updateConfigOpts(options, environment, cmdline)
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 491, in
updateConfigOpts
    self.reset()
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 1717, in reset
    self.handlePRServ()
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 383, in
handlePRServ
    self.prhost = prserv.serv.auto_start(self.data)
  File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 318, in
auto_start
    singleton.start()
  File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 133, in
start
    self.port = int(self.prserv.address.rsplit(':', 1)[1])
AttributeError: 'NoneType' object has no attribute 'rsplit'

after removing the rsplit it shows better error message:

bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
ERROR: PRservice localhost:0 not available
ERROR: Unable to start PR Server, exitting

It would be nice to improve the error handling a bit.

Regards,

--00000000000089882305ca787fc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>On Thu, Aug 19, 2021 at 6:47 PM Scot=
t Murray &lt;<a href=3D"mailto:scott.murray@konsulko.com" target=3D"_blank"=
>scott.murray@konsulko.com</a>&gt; wrote:<br></div></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Paul Barke=
r &lt;<a href=3D"mailto:pbarker@konsulko.com" target=3D"_blank">pbarker@kon=
sulko.com</a>&gt;<br>
<br>
Update the prserv client and server classes to use the modern json and<br>
asyncio based RPC system implemented by the asyncrpc module.<br>
<br>
Signed-off-by: Paul Barker &lt;<a href=3D"mailto:pbarker@konsulko.com" targ=
et=3D"_blank">pbarker@konsulko.com</a>&gt;<br>
[updated for asyncrpc changes, client split to separate file]<br>
Signed-off-by: Scott Murray &lt;<a href=3D"mailto:scott.murray@konsulko.com=
" target=3D"_blank">scott.murray@konsulko.com</a>&gt;<br><br></blockquote><=
div>....</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
-=C2=A0 =C2=A0 def export(self,version=3DNone, pkgarch=3DNone, checksum=3DN=
one, colinfo=3DTrue):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.connection.export(version, pkgarch=
, checksum, colinfo)<br>
+class PRServSingleton(object):<br>
+=C2=A0 =C2=A0 def __init__(self, dbfile, logfile, host, port):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.dbfile =3D dbfile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logfile =3D logfile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.host =3D host<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.port =3D port<br>
<br>
-=C2=A0 =C2=A0 def importone(self, version, pkgarch, checksum, value):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.connection.importone(version, pkga=
rch, checksum, value)<br>
+=C2=A0 =C2=A0 def start(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prserv =3D PRServer(self.dbfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prserv.start_tcp_server(self.host, self.p=
ort)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process =3D self.prserv.serve_as_process(=
)<br>
<br>
-=C2=A0 =C2=A0 def getinfo(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.host, self.port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.port:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.port =3D int(self.prserv.ad=
dress.rsplit(&#39;:&#39;, 1)[1])<br><br></blockquote><div><br></div><div>Hi=
,</div><div><br></div><div>I&#39;ve tried this when running inside docker c=
ontainer and it failed with a bit ugly exception:</div><div><br></div>bitba=
ke@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native<br>Traceba=
ck (most recent call last):<br>=C2=A0 File &quot;/OE/nodistro/honister/bitb=
ake/bin/bitbake&quot;, line 35, in &lt;module&gt;<br>=C2=A0 =C2=A0 sys.exit=
(bitbake_main(BitBakeConfigParameters(sys.argv),<br>=C2=A0 File &quot;/OE/n=
odistro/honister/bitbake/lib/bb/main.py&quot;, line 385, in bitbake_main<br=
>=C2=A0 =C2=A0 return ui_module.main(server_connection.connection, server_c=
onnection.events,<br>=C2=A0 File &quot;/OE/nodistro/honister/bitbake/lib/bb=
/ui/knotty.py&quot;, line 397, in main<br>=C2=A0 =C2=A0 params.updateToServ=
er(server, os.environ.copy())<br>=C2=A0 File &quot;/OE/nodistro/honister/bi=
tbake/lib/bb/cookerdata.py&quot;, line 75, in updateToServer<br>=C2=A0 =C2=
=A0 raise Exception(&quot;Unable to update the server configuration with lo=
cal parameters: %s&quot; % error)<br>Exception: Unable to update the server=
 configuration with local parameters: Traceback (most recent call last):<br=
>=C2=A0 File &quot;/OE/nodistro/honister/bitbake/lib/bb/command.py&quot;, l=
ine 90, in runCommand<br>=C2=A0 =C2=A0 result =3D command_method(self, comm=
andline)<br>=C2=A0 File &quot;/OE/nodistro/honister/bitbake/lib/bb/command.=
py&quot;, line 286, in updateConfig<br>=C2=A0 =C2=A0 command.cooker.updateC=
onfigOpts(options, environment, cmdline)<br>=C2=A0 File &quot;/OE/nodistro/=
honister/bitbake/lib/bb/cooker.py&quot;, line 491, in updateConfigOpts<br>=
=C2=A0 =C2=A0 self.reset()<br>=C2=A0 File &quot;/OE/nodistro/honister/bitba=
ke/lib/bb/cooker.py&quot;, line 1717, in reset<br>=C2=A0 =C2=A0 self.handle=
PRServ()<br>=C2=A0 File &quot;/OE/nodistro/honister/bitbake/lib/bb/cooker.p=
y&quot;, line 383, in handlePRServ<br>=C2=A0 =C2=A0 self.prhost =3D prserv.=
serv.auto_start(self.data)<br>=C2=A0 File &quot;/OE/nodistro/honister/bitba=
ke/lib/prserv/serv.py&quot;, line 318, in auto_start<br>=C2=A0 =C2=A0 singl=
eton.start()<br>=C2=A0 File &quot;/OE/nodistro/honister/bitbake/lib/prserv/=
serv.py&quot;, line 133, in start<br>=C2=A0 =C2=A0 self.port =3D int(self.p=
rserv.address.rsplit(&#39;:&#39;, 1)[1])<br>AttributeError: &#39;NoneType&#=
39; object has no attribute &#39;rsplit&#39;<br><div><br></div><div>after r=
emoving the rsplit it shows better error message:</div><div><br></div><div>=
bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native<br>WA=
RNING: Error talking to server: Multiple exceptions: [Errno 111] Connect ca=
ll failed (&#39;127.0.0.1&#39;, 0), [Errno 99] Cannot assign requested addr=
ess<br>WARNING: Error talking to server: Multiple exceptions: [Errno 111] C=
onnect call failed (&#39;127.0.0.1&#39;, 0), [Errno 99] Cannot assign reque=
sted address<br>WARNING: Error talking to server: Multiple exceptions: [Err=
no 111] Connect call failed (&#39;127.0.0.1&#39;, 0), [Errno 99] Cannot ass=
ign requested address<br>WARNING: Error talking to server: Multiple excepti=
ons: [Errno 111] Connect call failed (&#39;127.0.0.1&#39;, 0), [Errno 99] C=
annot assign requested address<br>ERROR: PRservice localhost:0 not availabl=
e<br>ERROR: Unable to start PR Server, exitting=C2=A0</div><div><br></div><=
div>It would be nice to improve the error handling a bit.</div><div><br></d=
iv><div>Regards,</div></div></div>

--00000000000089882305ca787fc7--
