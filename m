Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
	[209.85.213.172])
	by mail.openembedded.org (Postfix) with ESMTP id 3CD8F7689C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 22:48:23 +0000 (UTC)
Received: by igcse8 with SMTP id se8so59769312igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=HHnBfQk8xvFfrX3aSs1q/8nIfrnKgT1GWZLLb2o0oco=;
	b=PqHFbBuTH4wM04IyFuxks454bdv7ps/QzDHhbqrrc9Fxu6TAgerllhSNJxG33upmVb
	0Tp7pg6i9woPQfodt/yoNSj8kI1gvk286ajFUqBdCDcQW9k9PppuyNNrMmYx4SeKS7dv
	0Fv+YqP/KuBShnFNHYCouW4IuVJfHDHbIWkmI9JHJRC46Esga3eOREFOD+yej++zO+hC
	rfsOV3f37Wp01/9+M7QwX77+J51uG7Aiucv5l3BYT+TRPnK8/pYGQ/+wP6HR6ns4UezZ
	5cY+hzvu1NYqZPYkxeRrvu0kBSt/u3xxA4H5vpR10lQ14z0spCjBaDuUZrxAd9YAzjrY
	VFVA==
X-Received: by 10.50.103.71 with SMTP id fu7mr18347090igb.38.1440456503799;
	Mon, 24 Aug 2015 15:48:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Mon, 24 Aug 2015 15:48:04 -0700 (PDT)
In-Reply-To: <1440455520-29987-2-git-send-email-kergoth@gmail.com>
References: <1440455520-29987-1-git-send-email-kergoth@gmail.com>
	<1440455520-29987-2-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Mon, 24 Aug 2015 15:48:04 -0700
X-Google-Sender-Auth: j7GTLN5oMh2M62KpfUaDKahiCe0
Message-ID: <CABcZANnFqedTVObdid-UQbMgCWOCNKegN5tnMFxg_NTguMx6dw@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 2/2] bb.cookerdata: include useful traceback for ExpansionError/ParseError
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
X-List-Received-Date: Mon, 24 Aug 2015 22:48:25 -0000
Content-Type: multipart/alternative; boundary=047d7b2e11e7393958051e166a9f

--047d7b2e11e7393958051e166a9f
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 24, 2015 at 3:32 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> Show the user only the portion of the traceback which was from the
> metadata,
> nothing from bitbake's internal calls.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/cookerdata.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 57fc6bb..a033266 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -179,7 +179,16 @@ def catch_parse_error(func):
>              parselog.critical("Unable to parse %s: %s" % (fn, exc))
>              sys.exit(1)
>          except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
> -            parselog.critical("Unable to parse %s: %s" % (fn, exc))
> +            import traceback
> +
> +            bbdir = os.path.dirname(__file__) + os.sep
> +            exc_class, exc, tb = sys.exc_info()
> +            for tb in iter(lambda: tb.tb_next, None):
> +                # Skip frames in bitbake itself, we only want the metadata
> +                fn, _, _, _ = traceback.extract_tb(tb, 1)[0]
> +                if not fn.startswith(bbdir):
> +                    break
> +            parselog.critical("Unable to parse %s", fn,
> exc_info=(exc_class, exc, tb))
>              sys.exit(1)
>      return wrapped
>


Before:

$ bitbake -p
ERROR: Unable to parse conf/bitbake.conf: Failure expanding variable
FOO[:=], expression was ${@foo(d)} which triggered exception NameError:
global name 'sys' is not defined

After:

$ bitbake -p
ERROR: Unable to parse FOO[:=]
Traceback (most recent call last):
  File "FOO[:=]", line 1, in <module>
  File "test.inc", line 2, in foo(d=<bb.data_smart.DataSmart object at
0x99ff6cc>)
  File "test.inc", line 2, in bar(d=<bb.data_smart.DataSmart object at
0x99ff6cc>)
ExpansionError: Failure expanding variable FOO[:=], expression was
${@foo(d)} which triggered exception NameError: global name 'sys' is not
defined

There's still room for improvement, obviously. I'd like those filenames and
line numbers to be correct absolute paths with correct adjusted line
numbers and something other than <module> for the "function" of a :=,
possibly, but it's a start.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b2e11e7393958051e166a9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 24, 2015 at 3:32 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D":yi" class=3D"" style=3D"=
overflow:hidden">From: Christopher Larson &lt;<a href=3D"mailto:chris_larso=
n@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
Show the user only the portion of the traceback which was from the metadata=
,<br>
nothing from bitbake&#39;s internal calls.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/cookerdata.py | 11 ++++++++++-<br>
=C2=A01 file changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py<br>
index 57fc6bb..a033266 100644<br>
--- a/lib/bb/cookerdata.py<br>
+++ b/lib/bb/cookerdata.py<br>
@@ -179,7 +179,16 @@ def catch_parse_error(func):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parselog.critical(&quot;Una=
ble to parse %s: %s&quot; % (fn, exc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (bb.parse.ParseError, bb.data_smar=
t.ExpansionError) as exc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parselog.critical(&quot;Unable t=
o parse %s: %s&quot; % (fn, exc))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import traceback<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bbdir =3D os.path.dirname(__file=
__) + os.sep<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exc_class, exc, tb =3D sys.exc_i=
nfo()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for tb in iter(lambda: tb.tb_nex=
t, None):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Skip frames in b=
itbake itself, we only want the metadata<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn, _, _, _ =3D tr=
aceback.extract_tb(tb, 1)[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not fn.startswi=
th(bbdir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parselog.critical(&quot;Unable t=
o parse %s&quot;, fn, exc_info=3D(exc_class, exc, tb))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
=C2=A0 =C2=A0 =C2=A0return wrapped</div></blockquote></div><br><div><div><b=
r></div><div>Before:</div><div><br></div><div>$ bitbake -p</div><div>ERROR:=
 Unable to parse conf/bitbake.conf: Failure expanding variable FOO[:=3D], e=
xpression was ${@foo(d)} which triggered exception NameError: global name &=
#39;sys&#39; is not defined</div><div><br></div><div>After:</div><div><br><=
/div><div>$ bitbake -p</div><div>ERROR: Unable to parse FOO[:=3D]</div><div=
>Traceback (most recent call last):</div><div>=C2=A0 File &quot;FOO[:=3D]&q=
uot;, line 1, in &lt;module&gt;</div><div>=C2=A0 File &quot;test.inc&quot;,=
 line 2, in foo(d=3D&lt;bb.data_smart.DataSmart object at 0x99ff6cc&gt;)</d=
iv><div>=C2=A0 File &quot;test.inc&quot;, line 2, in bar(d=3D&lt;bb.data_sm=
art.DataSmart object at 0x99ff6cc&gt;)</div><div>ExpansionError: Failure ex=
panding variable FOO[:=3D], expression was ${@foo(d)} which triggered excep=
tion NameError: global name &#39;sys&#39; is not defined</div></div><div><b=
r></div><div>There&#39;s still room for improvement, obviously. I&#39;d lik=
e those filenames and line numbers to be correct absolute paths with correc=
t adjusted line numbers and something other than &lt;module&gt; for the &qu=
ot;function&quot; of a :=3D, possibly, but it&#39;s a start.</div>-- <br><d=
iv class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergoth=
 at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintai=
ner - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--047d7b2e11e7393958051e166a9f--
