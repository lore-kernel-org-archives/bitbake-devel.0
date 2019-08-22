Return-Path: <kergoth@gmail.com>
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
	[209.85.215.171])
	by mail.openembedded.org (Postfix) with ESMTP id C4F8B7E265
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 14:14:40 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id u17so3752795pgi.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:message-id:in-reply-to:references:subject:mime-version; 
	bh=ZLQUJwvd9uE5sjk1BgGLVt7R7Gmkp1QV+jYuljCWjNI=;
	b=NIfobVN5tTWhA99qhxLn0wK/1gJMMVoepp/eAa5G1Vvnfe5qNvHG0SuQGbC2k2/lpM
	CaKRlqCMycnppmzEJDgAGR8V4U2qpL4ESsjnakFFC74ZN5nSqVTaPEt26NEmdXaeefy2
	/7roCONWfg1EvuB9qOTrqA1YBtbgKKDzN+iX7pi+hWjMFjyMRexdcAQDH75ovJbhiUx6
	Md8GH5rlFF+eIxn0EpmBsyVMudI4qxTb4B78x9mSOj+w/XJkJjJ5gnmUOV7dtFwDvpfg
	VzVVADzlK73Cp2icxD0yZdMlEyqDxH9rtwGKHICzfrcRaLpWikIzyO6JJH1xDIASx6x2
	mMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
	:subject:mime-version;
	bh=ZLQUJwvd9uE5sjk1BgGLVt7R7Gmkp1QV+jYuljCWjNI=;
	b=Qi3/6STkjnk+gYR9FTQ8gWUCJF7W6EyUwvb4zPEq9Zwpi+zymziIBRcpqMwTSPKCs+
	TI38mnGrAmGjMKvEbz71KwCmn7LTGEcvCsgjhvsRyCjN09cYTYO/CGdrxDLjdmnu1WPQ
	6lUzWSrbwXyu/xbV/hPT5n19w1KOFzhhKM+XGYD61CNz+P/1WiaT7EuvxqkOnfiPy2Js
	TH+fO5xGM2fTqSlKDT8af4V2swK5jdMSJnb2b2W35fNDmhwl8LIXGXdgxlaTxn7zTzq7
	CrRaFRoAftmluXVA7iw5+n5s0+92s4op7spT6aceShpdvVrXz4p13loRFvM13jjVp8E2
	FpGA==
X-Gm-Message-State: APjAAAVMag06emUM5/3rcBj1zAGI15+I1l1AXdOKNvEHTSLa8XJhiAzy
	VynMsrRDpmYFr1yIrLZnFGEHM89p
X-Google-Smtp-Source: APXvYqxhm/m72JKQVlPL4YjSrXdE/UBr1z3LnJaXHmtNbn8BgKV7uEQUCtuYlOG0b6k5ZISANvNwzA==
X-Received: by 2002:a17:90a:ac11:: with SMTP id
	o17mr5812999pjq.104.1566483281482; 
	Thu, 22 Aug 2019 07:14:41 -0700 (PDT)
Received: from [192.168.1.17] (ip70-180-21-74.ph.ph.cox.net. [70.180.21.74])
	by smtp.gmail.com with ESMTPSA id
	o129sm28537582pfg.1.2019.08.22.07.14.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Aug 2019 07:14:40 -0700 (PDT)
Date: Thu, 22 Aug 2019 07:14:33 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Robert Yang
	<liezhi.yang@windriver.com>
Message-ID: <6c3c318c-9e88-48b6-80c0-b98a8b79e759@Spark>
In-Reply-To: <3562c905fd50bb986aba8a40778245a026339c93.1566459309.git.liezhi.yang@windriver.com>
References: <cover.1566459309.git.liezhi.yang@windriver.com>
	<3562c905fd50bb986aba8a40778245a026339c93.1566459309.git.liezhi.yang@windriver.com>
X-Readdle-Message-ID: 6c3c318c-9e88-48b6-80c0-b98a8b79e759@Spark
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: cooker: Kill alive process before join it
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
X-List-Received-Date: Thu, 22 Aug 2019 14:14:40 -0000
Content-Type: multipart/alternative; boundary="5d5ea34e_625558ec_dbd3"

--5d5ea34e_625558ec_dbd3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Looks like you=E2=80=99re partially duplicating what the =E2=80=98force=E2=
=80=99 logic does already, but for the non-force case as well, yes=3F pro=
cess.terminate() sounds a lot like sending a SIGTERM, though admittedly I=
 haven=E2=80=99t read the code to Process recently. Perhaps if this is tr=
uly necessary, the logic can be simplified.
On Aug 22, 2019, 12:10 AM -0700, Robert Yang <liezhi.yang=40windriver.com=
>, wrote:
> =46ixed:
> =24 echo helloworld >> meta/recipes-extended/bash/bash=5F4.4.18.bb
> =24 while true; do kill-bb; rm -fr bitbake-cookerdaemon.log tmp/cache/d=
efault-glibc/qemux86-64/x86=5F64/bb=5Fcache.dat* ; bitbake -p; done
>
> It may hang in 10 mins, there are two problems:
> * There might be deadlocks when call process.join() if the queue is not=
 NULL,
> so we need cleanup the queue before join() it, but:
> * The self.result=5Fqueue.get(timeout=3D0.25) may hang if the queue.=5F=
wlock is hold
> by SomeOtherProcess, the queue has the following info when it hangs:
> '=5Fwlock': <Lock(owner=3DSomeOtherProcess)>, so that we may can't clea=
n up the
> queue.
>
> We can kill alvie process before join it to fix the problems.
>
> Signed-off-by: Robert Yang <liezhi.yang=40windriver.com>
> ---
> bitbake/lib/bb/cooker.py =7C 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 0607fcc..e42bcba 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> =40=40 -2082,19 +2082,15 =40=40 class CookerParser(object):
> for process in self.processes:
> self.parser=5Fquit.put(None)
>
> - =23 Cleanup the queue before call process.join(), otherwise there mig=
ht be
> - =23 deadlocks.
> - while True:
> - try:
> - self.result=5Fqueue.get(timeout=3D0.25)
> - except queue.Empty:
> - break
> -
> for process in self.processes:
> if force:
> process.join(.1)
> process.terminate()
> else:
> + =23 Kill the alive process firstly before join() it to avoid
> + =23 deadlocks
> + if process.is=5Falive():
> + os.kill(process.pid, 9)
> process.join()
>
> sync =3D threading.Thread(target=3Dself.bb=5Fcache.sync)
> --
> 2.7.4
>
> --
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> bitbake-devel mailing list
> bitbake-devel=40lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--5d5ea34e_625558ec_dbd3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Looks like you=E2=80=99re partially duplicating wha=
t the =E2=80=98force=E2=80=99 logic does already, but for the non-force c=
ase as well, yes=3F process.terminate() sounds a lot like sending a SIGTE=
RM, though admittedly I haven=E2=80=99t read the code to Process recently=
. Perhaps if this is truly necessary, the logic can be simplified.</div>
</div>
<div name=3D=22messageReplySection=22>On Aug 22, 2019, 12:10 AM -0700, Ro=
bert Yang &lt;liezhi.yang=40windriver.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>=46=
ixed:<br />
=24 echo helloworld &gt;&gt; meta/recipes-extended/bash/bash=5F4.4.18.bb<=
br />
=24 while true; do kill-bb; rm -fr bitbake-cookerdaemon.log tmp/cache/def=
ault-glibc/qemux86-64/x86=5F64/bb=5Fcache.dat* ; bitbake -p; done<br />
<br />
It may hang in 10 mins, there are two problems:<br />
* There might be deadlocks when call process.join() if the queue is not N=
ULL,<br />
so we need cleanup the queue before join() it, but:<br />
* The self.result=5Fqueue.get(timeout=3D0.25) may hang if the queue.=5Fwl=
ock is hold<br />
by SomeOtherProcess, the queue has the following info when it hangs:<br /=
>
'=5Fwlock': &lt;Lock(owner=3DSomeOtherProcess)&gt;, so that we may can't =
clean up the<br />
queue.<br />
<br />
We can kill alvie process before join it to fix the problems.<br />
<br />
Signed-off-by: Robert Yang &lt;liezhi.yang=40windriver.com&gt;<br />
---<br />
bitbake/lib/bb/cooker.py =7C 12 ++++--------<br />
1 file changed, 4 insertions(+), 8 deletions(-)<br />
<br />
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br />
index 0607fcc..e42bcba 100644<br />
--- a/bitbake/lib/bb/cooker.py<br />
+++ b/bitbake/lib/bb/cooker.py<br />
=40=40 -2082,19 +2082,15 =40=40 class CookerParser(object):<br />
for process in self.processes:<br />
self.parser=5Fquit.put(None)<br />
<br />
- =23 Cleanup the queue before call process.join(), otherwise there might=
 be<br />
- =23 deadlocks.<br />
- while True:<br />
- try:<br />
- self.result=5Fqueue.get(timeout=3D0.25)<br />
- except queue.Empty:<br />
- break<br />
-<br />
for process in self.processes:<br />
if force:<br />
process.join(.1)<br />
process.terminate()<br />
else:<br />
+ =23 Kill the alive process firstly before join() it to avoid<br />
+ =23 deadlocks<br />
+ if process.is=5Falive():<br />
+ os.kill(process.pid, 9)<br />
process.join()<br />
<br />
sync =3D threading.Thread(target=3Dself.bb=5Fcache.sync)<br />
--<br />
2.7.4<br />
<br />
--<br />
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br />
bitbake-devel mailing list<br />
bitbake-devel=40lists.openembedded.org<br />
http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br /></block=
quote>
</div>
</body>
</html>

--5d5ea34e_625558ec_dbd3--
