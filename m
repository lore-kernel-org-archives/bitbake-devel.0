Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51])
	by mail.openembedded.org (Postfix) with ESMTP id 8B12974197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 17:34:50 +0000 (UTC)
Received: by vkhf67 with SMTP id f67so42489971vkh.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=cFm8uXaE+dSsVatWJePahO+gNRmn+UnhXF3dLZ4Fatg=;
	b=EknwXOZOH/jSMoRTEdHUghkiUv+6QkS+B1nq8mYABfy+3dF84OJNj1l1d6oJyAFa4p
	y1Qc0ga00b4Z3rqupUcl6GJOlXZa4Ic/Y65XdRLGalsTz2+dlHK5DTUrSrVUyi8Y2PFV
	LDm7ZEJ2scHigy4Ca7Y9v78y7HNY+RD1TZRBV9x8SgDzOAd4rF2PQHMvrFIdMzY5brNb
	4SYLD592uh2t2vZe6y0VvVP0yAkMdCZpqmqQCQY3IuXhLrdBmANIzPuJT+gh9Bko8EiD
	EKxDUezmr6TQXklIoO/Lt2Twr4flE1/YQslTjHMajZlVEv8AV85s3C5b7XhFd6CoR64u
	mvgg==
X-Received: by 10.52.230.130 with SMTP id sy2mr22843741vdc.50.1441042490709;
	Mon, 31 Aug 2015 10:34:50 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.31.203.2 with HTTP; Mon, 31 Aug 2015 10:34:31 -0700 (PDT)
In-Reply-To: <1441041701-27060-1-git-send-email-alejandro.franco@linux.intel.com>
References: <1441041701-27060-1-git-send-email-alejandro.franco@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 31 Aug 2015 10:34:31 -0700
X-Google-Sender-Auth: tWhn_uaVC0NPBPXv1zthLNp7rzA
Message-ID: <CABcZAN=NmMuptP56uBvUfdwC_QAR1q9Ysj+DhtLhed18GRfrQw@mail.gmail.com>
To: Alex Franco <alejandro.franco@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Allow bitbake commands starting with do_
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
X-List-Received-Date: Mon, 31 Aug 2015 17:34:54 -0000
Content-Type: multipart/alternative; boundary=001a11c25544c3de21051e9ed905

--001a11c25544c3de21051e9ed905
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 31, 2015 at 10:21 AM, Alex Franco <
alejandro.franco@linux.intel.com> wrote:

> The output of "bitbake, -c listtasks pkg" lists tasks with their real
> names
> (starting with "do_"), but then "bitbake -c do_task" fails, as "do_"
> always
> gets unconditionally prepended to task names. This patch handles this error
> by always removing "do_" from the beginning of task names when the runqueue
> is being constructed.
>
> [YOCTO #7818]
>
> Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0f99e5a..4a0f01a 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -634,6 +634,10 @@ class RunQueueData:
>
>              fnid = taskData.build_targets[targetid][0]
>              fn = taskData.fn_index[fnid]
> +
> +            import re
> +            target[1] = re.sub("^do_", "", target[1])
> +
>              self.target_pairs.append((fn, target[1]))
>

You don't need to use a regular expression for this. Also, imports belong
at the top of the file anyway.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c25544c3de21051e9ed905
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 31, 2015 at 10:21 AM, Alex Franco <span dir=3D"ltr">&lt;<a href=
=3D"mailto:alejandro.franco@linux.intel.com" target=3D"_blank">alejandro.fr=
anco@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div id=3D":20e" class=3D"a3s" style=3D"overflow:hidden">The output of &q=
uot;<span class=3D"il">bitbake</span>, -c listtasks pkg&quot; lists tasks w=
ith their real names<br>
(starting with &quot;do_&quot;), but then &quot;<span class=3D"il">bitbake<=
/span> -c do_task&quot; fails, as &quot;do_&quot; always<br>
gets unconditionally prepended to task names. This patch handles this error=
<br>
by always removing &quot;do_&quot; from the beginning of task names when th=
e runqueue<br>
is being constructed.<br>
<br>
[YOCTO #7818]<br>
<br>
Signed-off-by: Alex Franco &lt;<a href=3D"mailto:alejandro.franco@linux.int=
el.com">alejandro.franco@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ru=
nqueue.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</s=
pan>/runqueue.py b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il"=
>bb</span>/runqueue.py<br>
index 0f99e5a..4a0f01a 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ru=
nqueue.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ru=
nqueue.py<br>
@@ -634,6 +634,10 @@ <span class=3D"il">class</span> RunQueueData:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fnid =3D taskData.build_tar=
gets[targetid][0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn =3D taskData.fn_index[fn=
id]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import re<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target[1] =3D re.sub(&quot;^do_&=
quot;, &quot;&quot;, target[1])<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.target_pairs.append((f=
n, target[1]))</div></blockquote></div><br>You don&#39;t need to use a regu=
lar expression for this. Also, imports belong at the top of the file anyway=
.<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at=
 kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintain=
er - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a11c25544c3de21051e9ed905--
