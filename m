Received: from mail-lb0-f171.google.com ([209.85.217.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1UchVF-0002B9-7g
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 May 2013 21:37:03 +0200
Received: by mail-lb0-f171.google.com with SMTP id v20so2282796lbc.30
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 May 2013 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=4E1G9G1ckKkko7Dpa19uq08AWNgmV68znT2mYB6Q3R4=;
	b=ZDcLChNpQzZpcOHHJF9DgiGnPn6L2nb5+Og7HUvKsH4gYfqvAtU8wjb/x0z19NfmAg
	qFYTB/rJIpD9v2n0+BPzH41TuqB9TGFEv7OqCqOB1Lhjg43UuNJzQM+0vFihGvkNDkas
	hZCXXjDXhct1Hgauspdn9REqO0SfJpW5HfgCl9cwUc0Vqoy/UWNVwceYFjNJ566DfF4K
	Byl6o9F1DJaqut6jfZifTjl5LfjbecM+fJ+U6rSqarFnTn+eHA+QcDZ2IrEdUbnpa+TS
	SwiDTLAw6G45p8yNcj/ga+pyVrwN+7SBWLARf3RJbu2VilyK8YNBVfjf9KyWiHZBhXj4
	4d2g==
X-Received: by 10.112.89.231 with SMTP id br7mr5009523lbb.120.1368645511873;
	Wed, 15 May 2013 12:18:31 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.141.74 with HTTP; Wed, 15 May 2013 12:18:11 -0700 (PDT)
In-Reply-To: <CAFpw0gLkmOEVbXdVz8ihKNaqaHKSfghYuLo4CjqZUEDmKKwTtQ@mail.gmail.com>
References: <CAFpw0gLkmOEVbXdVz8ihKNaqaHKSfghYuLo4CjqZUEDmKKwTtQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 15 May 2013 12:18:11 -0700
X-Google-Sender-Auth: thhJhkMfedAyMG12jNWd9qth71g
Message-ID: <CABcZANnn446temrxab90iuu+N1JStWFYTiDgLZOpoWN-26PULA@mail.gmail.com>
To: Francois Retief <fgretief@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: How to determine a flowId for log messages?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 15 May 2013 19:37:04 -0000
Content-Type: multipart/alternative; boundary=001a11c36b068f0d6904dcc69d1f

--001a11c36b068f0d6904dcc69d1f
Content-Type: text/plain; charset=UTF-8

On Wed, May 15, 2013 at 10:54 AM, Francois Retief <fgretief@gmail.com>wrote:

> At work we use TeamCity [1] as our CI server.  I have written a small
> patch (attached to email) to extend bitbake to output log messages in
> TeamCity's Service Message format [2]. This allow us to better communicate
> warnings and errors to the server.
>
> I did this by overriding the BBLogFormatter class in knotty.py. The output
> is formatted with timestamp, text, errorDetails and status fields so that
> the TeamCity server can augment the logs with color and terminate if errors
> occur.
>
> TeamCity also has a *flowId* field that is used as a unique identifier to
> distinguish between separate processes running in parallel. On the server,
> all messages with the same *flowId* is grouped together. I would like to
> use it with bitbake.
>
> What bitbake logging attribute do I need to monitor to determine the *
> flowId* of a message?
>
> I tried to use the taskId attribute in the logging record, but most of the
> time it is set to either zero or not there at all.
>
>         if hasattr(record, 'taskpid') and record.taskpid != 0:
>             msg += " flowId='%s'" % record.taskpid
>
> Are there any other way to identify log messages for grouping them
> together?
>
> Or any alternative methods? Am I on the right track,
> or do I need to write a whole new ui for this?
>

'pid' on events and 'taskpid' on log records should always correspond to
the process id of the spawned task. If it's not set, then it's likely that
log message wasn't recorded in task context, but elsewhere, e.g. from an
event handler, or general global log messages. Afaik. See msg.py and
event.py, as well as fork_off_task in the runqueue for details.
-- 
Christopher Larson

--001a11c36b068f0d6904dcc69d1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, May 15, 2013 at 10:54 AM, Francois Retief <span dir=3D"ltr">&lt;<a =
href=3D"mailto:fgretief@gmail.com" target=3D"_blank">fgretief@gmail.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div><div>At work we use TeamCity [1] a=
s our CI server.=C2=A0 I have written a small patch (attached to email) to =
extend bitbake to output log messages in TeamCity&#39;s Service Message for=
mat [2]. This allow us to better communicate warnings and errors to the ser=
ver.<br>


<br></div>I did this by overriding the BBLogFormatter class in knotty.py. T=
he output is formatted with timestamp, text, errorDetails and status fields=
 so that the TeamCity server can augment the logs with color and terminate =
if errors occur.<br>


<br></div>TeamCity also has a <b>flowId</b> field that is used as a unique =
identifier to distinguish between separate processes running in parallel. O=
n the server, all messages with the same <b>flowId</b> is grouped together.=
 I would like to use it with bitbake.<br>


<br></div><div>What bitbake logging attribute do I need to monitor to deter=
mine the <b>flowId</b> of a message?<br><br></div><div>I tried to use the t=
askId attribute in the logging record, but most of the time it is set to ei=
ther zero or not there at all. <br>


<br></div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if hasattr(record, &#3=
9;taskpid&#39;) and record.taskpid !=3D 0:<br><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg +=3D &quot; flowId=3D&#39;%s=
&#39;&quot; % record.taskpid<br></div><div><br></div><div>Are there any oth=
er way to identify log messages for grouping them together?<br>


</div><div><br>Or any alternative methods? Am I on the right track, <br>or =
do I need to write a whole new ui for this?</div></blockquote></div><br>&#3=
9;pid&#39; on events and &#39;taskpid&#39; on log records should always cor=
respond to the process id of the spawned task. If it&#39;s not set, then it=
&#39;s likely that log message wasn&#39;t recorded in task context, but els=
ewhere, e.g. from an event handler, or general global log messages. Afaik. =
See msg.py and event.py, as well as fork_off_task in the runqueue for detai=
ls.<br>

-- <br>Christopher Larson</div></div>

--001a11c36b068f0d6904dcc69d1f--
