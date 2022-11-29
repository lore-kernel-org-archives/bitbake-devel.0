Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0296C4332F
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 18:20:29 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.158603.1669746024431303895
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Nov 2022 10:20:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=g6ZAidQ2;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id w15so10261818wrl.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Nov 2022 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uskM/2UhaShp7BdY+cSVflPgJuRxOYaJbIYc6ERYPFU=;
        b=g6ZAidQ2Msp6DqdzaGC0K3si61sJsWBSwwx82EyQZEgnkvNt0S3dZR0v3Y24XtiWG1
         lfJke0JPKBxqUs1eeUjT4PqWHXu2odZiohVEWFUaXHvjpZmamdRR7Tx/kUJKqRNjZNEO
         AXhyqzUetslmyaEDvUP67x8QDil7kZbD8MB8usgTtmKpHO2/BYAiNISctyRHFF/KuY8R
         8UNgI1BtRcdFj5WNVOB5r0rFr5BlqJlGOT6XaWmtZIkJ/ix2fnDMCbvbxp7fUKGYEeWp
         f8b/VEUSYpIjj0NVDtkx43greTKnV82wfwjj8harapsJ7XsoRcPfYvDFvEDEiuHUruUN
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uskM/2UhaShp7BdY+cSVflPgJuRxOYaJbIYc6ERYPFU=;
        b=3Va2g8+d77dULfqfJXtgwaMiYuEeDI2hyufaGSmkdXZERXle56pz7c3RlUsXyGQ4mg
         xVttojNes4wKvUyS2Wf0jxzwxCtWUQaGuj1uPmAeX78H1dAcmZuBHNiNLRiZNpz0uuI+
         pj+qDIWWKP5rURYRW3gXgGffq0kKMrOPJX/SZSMoAW1r7swBN4Qc+DxyprEIr2Ssj8lY
         61bxizWU8dxoCL3VQ0GkxDgtWrXrt2u5eL+HSAX51DZvMAS5Xq6ip2FY6ak+quS8csDr
         THPgDdd0gtHWne6cn0OxETZGP0plkgi0GpLxGa9eJYiHkeB0spMnGq+quN4o4x6qZjC8
         jgCQ==
X-Gm-Message-State: ANoB5pkf3pyRuFziU/AWutNPsCddtpyClhBS2OlMZnRLE9GFz0FBZCvx
	yaGujOQmv5k6PgxXuWsOrGxSr/J0969WB8TlVNw=
X-Google-Smtp-Source: AA0mqf7XO59ESngZQLun9AE2yVRxJYobrb2H7GKfOXcRYB+3ji88cpzEEGgIDy0xalhjzhMwxwWE2LkQAN6ANSktils=
X-Received: by 2002:adf:bb04:0:b0:241:f868:578e with SMTP id
 r4-20020adfbb04000000b00241f868578emr18643285wrg.516.1669746022694; Tue, 29
 Nov 2022 10:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20221124091045.12018-1-Qi.Chen@windriver.com> <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
 <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 29 Nov 2022 19:20:10 +0100
Message-ID: <CA+chaQeFjOD-=ppAj063EVZkd3v6E7J+1JQSY134hgg0LoT10A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup bb.cache.parse_recipe
To: Chen Qi <Qi.Chen@windriver.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Yang, Liezhi" <Liezhi.Yang@windriver.com>
Content-Type: multipart/alternative; boundary="0000000000008c443205eea00a3b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Nov 2022 18:20:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14126

--0000000000008c443205eea00a3b
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 24, 2022 at 1:17 PM Chen Qi <Qi.Chen@windriver.com> wrote:

> Hi Richard,
>
> I met the error on our layerindex.
>

"our" is
https://layers.openembedded.org

or some other instance in windriver?

I'm asking because parsing on https://layers.openembedded.org seems to be
broken for a while. I've checked randomly selected 3 layers and all show
the same issue as "Updates" tab in:
https://layers.openembedded.org/layerindex/branch/master/layer/openembedded-core/

ERROR: fatal: Unable to create
'/opt/workdir/git___git_openembedded_org_bitbake/.git/index.lock': File
exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
ERROR: Traceback (most recent call last):
  File "update_layer.py", line 384, in main
    (tinfoil, tempdir) = recipeparse.init_parser(settings, branch,
bitbakepath, nocheckout=options.nocheckout, logger=logger)
  File "/opt/layerindex/layerindex/recipeparse.py", line 36, in init_parser
    utils.checkout_repo(bitbakepath, bitbake_ref, logger=logger)
  File "/opt/layerindex/layerindex/utils.py", line 282, in checkout_repo
    runcmd(['git', 'reset', '--hard'], repodir, logger=logger)
  File "/opt/layerindex/layerindex/utils.py", line 369, in runcmd
    raise e
subprocess.CalledProcessError: Command '['git', 'reset', '--hard']'
returned non-zero exit status 128.



> Error message is as below.
> NOTE: Starting bitbake server...
> ERROR: Unable to read
> /home/oelayer/layerindex/git___lxgit_wrs_com_layers_meta-arm/meta-arm/recipes-bsp/trusted
> -firmware-m/trusted-firmware-m_1.6.0.bb: Traceback (most recent call
> last):
>   File
> "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/command.py",
> line 90, in runCommand
>     result = command_method(self, commandline)
>   File
> "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/command.py",
> line 567, in parseRecipeFile
>     envdata = bb.cache.parse_recipe(config_data, fn, appendfiles, mc)['']
> AttributeError: module 'bb.cache' has no attribute 'parse_recipe'
>
> Regards,
> Qi
>
> -----Original Message-----
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> Sent: Thursday, November 24, 2022 8:02 PM
> To: Chen, Qi <Qi.Chen@windriver.com>; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup
> bb.cache.parse_recipe
>
> On Thu, 2022-11-24 at 01:10 -0800, Chen Qi wrote:
> > The parse_recipe has been removed from bb.cache, replace it with the
> > databuilder._parse_recipe.
> >
> > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > ---
> >  lib/bb/command.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/command.py b/lib/bb/command.py index
> > fa9fd054c..c9571f63d 100644
> > --- a/lib/bb/command.py
> > +++ b/lib/bb/command.py
> > @@ -564,7 +564,7 @@ class CommandsSync:
> >          if config_data:
> >              # We have to use a different function here if we're passing
> in a datastore
> >              # NOTE: we took a copy above, so we don't do it here again
> > -            envdata = bb.cache.parse_recipe(config_data, fn,
> appendfiles, mc)['']
> > +            envdata =
> > + command.cooker.databuilder._parse_recipe(config_data, fn,
> > + appendfiles, mc)['']
> >          else:
> >              # Use the standard path
> >              envdata = command.cooker.databuilder.parseRecipe(fn,
> > appendfiles)
>
> How did you run into that? I'm a bit worried we're missing some test
> coverage here?
>
> Cheers,
>
> Richard
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14107):
> https://lists.openembedded.org/g/bitbake-devel/message/14107
> Mute This Topic: https://lists.openembedded.org/mt/95234638/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000008c443205eea00a3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Nov 24, 2022 at 1:17 PM Chen Qi &=
lt;<a href=3D"mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a>&gt; w=
rote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Richard,<br>
<br>
I met the error on our layerindex.<br></blockquote><div><br></div><div>&quo=
t;our&quot; is</div><div><a href=3D"https://layers.openembedded.org">https:=
//layers.openembedded.org</a></div><div><br></div><div>or some other instan=
ce in windriver?</div><div><br></div><div>I&#39;m asking because parsing on=
=C2=A0<a href=3D"https://layers.openembedded.org">https://layers.openembedd=
ed.org</a> seems to be broken for a while. I&#39;ve checked randomly select=
ed 3 layers and all show the same issue as &quot;Updates&quot; tab in:</div=
><div><a href=3D"https://layers.openembedded.org/layerindex/branch/master/l=
ayer/openembedded-core/">https://layers.openembedded.org/layerindex/branch/=
master/layer/openembedded-core/</a><br></div><div><br></div><div>ERROR: fat=
al: Unable to create &#39;/opt/workdir/git___git_openembedded_org_bitbake/.=
git/index.lock&#39;: File exists.<br><br>Another git process seems to be ru=
nning in this repository, e.g.<br>an editor opened by &#39;git commit&#39;.=
 Please make sure all processes<br>are terminated then try again. If it sti=
ll fails, a git process<br>may have crashed in this repository earlier:<br>=
remove the file manually to continue.<br>ERROR: Traceback (most recent call=
 last):<br>=C2=A0 File &quot;update_layer.py&quot;, line 384, in main<br>=
=C2=A0 =C2=A0 (tinfoil, tempdir) =3D recipeparse.init_parser(settings, bran=
ch, bitbakepath, nocheckout=3Doptions.nocheckout, logger=3Dlogger)<br>=C2=
=A0 File &quot;/opt/layerindex/layerindex/recipeparse.py&quot;, line 36, in=
 init_parser<br>=C2=A0 =C2=A0 utils.checkout_repo(bitbakepath, bitbake_ref,=
 logger=3Dlogger)<br>=C2=A0 File &quot;/opt/layerindex/layerindex/utils.py&=
quot;, line 282, in checkout_repo<br>=C2=A0 =C2=A0 runcmd([&#39;git&#39;, &=
#39;reset&#39;, &#39;--hard&#39;], repodir, logger=3Dlogger)<br>=C2=A0 File=
 &quot;/opt/layerindex/layerindex/utils.py&quot;, line 369, in runcmd<br>=
=C2=A0 =C2=A0 raise e<br>subprocess.CalledProcessError: Command &#39;[&#39;=
git&#39;, &#39;reset&#39;, &#39;--hard&#39;]&#39; returned non-zero exit st=
atus 128.<br></div><div><br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Error message is as below.<br>
NOTE: Starting bitbake server...<br>
ERROR: Unable to read /home/oelayer/layerindex/git___lxgit_wrs_com_layers_m=
eta-arm/meta-arm/recipes-bsp/trusted<br>
-firmware-m/<a href=3D"http://trusted-firmware-m_1.6.0.bb" rel=3D"noreferre=
r" target=3D"_blank">trusted-firmware-m_1.6.0.bb</a>: Traceback (most recen=
t call last):<br>
=C2=A0 File &quot;/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/=
bb/command.py&quot;, line 90, in runCommand<br>
=C2=A0 =C2=A0 result =3D command_method(self, commandline)<br>
=C2=A0 File &quot;/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/=
bb/command.py&quot;, line 567, in parseRecipeFile<br>
=C2=A0 =C2=A0 envdata =3D bb.cache.parse_recipe(config_data, fn, appendfile=
s, mc)[&#39;&#39;]<br>
AttributeError: module &#39;bb.cache&#39; has no attribute &#39;parse_recip=
e&#39;<br>
<br>
Regards,<br>
Qi<br>
<br>
-----Original Message-----<br>
From: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.o=
rg" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; <br>
Sent: Thursday, November 24, 2022 8:02 PM<br>
To: Chen, Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_blank"=
>Qi.Chen@windriver.com</a>&gt;; <a href=3D"mailto:bitbake-devel@lists.opene=
mbedded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup bb.cache.parse_rec=
ipe<br>
<br>
On Thu, 2022-11-24 at 01:10 -0800, Chen Qi wrote:<br>
&gt; The parse_recipe has been removed from bb.cache, replace it with the <=
br>
&gt; databuilder._parse_recipe.<br>
&gt; <br>
&gt; Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" ta=
rget=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/command.py | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/command.py b/lib/bb/command.py index <br>
&gt; fa9fd054c..c9571f63d 100644<br>
&gt; --- a/lib/bb/command.py<br>
&gt; +++ b/lib/bb/command.py<br>
&gt; @@ -564,7 +564,7 @@ class CommandsSync:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config_data:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We have to use a dif=
ferent function here if we&#39;re passing in a datastore<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # NOTE: we took a copy=
 above, so we don&#39;t do it here again<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D bb.cache.parse_=
recipe(config_data, fn, appendfiles, mc)[&#39;&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D <br>
&gt; + command.cooker.databuilder._parse_recipe(config_data, fn, <br>
&gt; + appendfiles, mc)[&#39;&#39;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use the standard pat=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 envdata =3D command.co=
oker.databuilder.parseRecipe(fn, <br>
&gt; appendfiles)<br>
<br>
How did you run into that? I&#39;m a bit worried we&#39;re missing some tes=
t coverage here?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14107): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14107" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14107</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/95234638/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/95234638/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000008c443205eea00a3b--

