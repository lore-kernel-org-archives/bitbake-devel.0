Return-Path: <katutxakurra@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C794C77B7C
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 10:52:22 +0000 (UTC)
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
 by mx.groups.io with SMTP id smtpd.web10.28780.1683629532598889712
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 May 2023 03:52:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=DTROYDls;
 spf=pass (domain: gmail.com, ip: 209.85.167.66, mailfrom: katutxakurra@gmail.com)
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-4f24ceae142so2943562e87.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683629530; x=1686221530;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYZR/G37tnsP7yUGSmNpBPI4OE2VINyICKexijTrIrs=;
        b=DTROYDlsDgqmcmOR7GstB2+LNruVopVjxIOB0RTGKvPhRwjRDtTqAktss106Po9sO3
         PFjbHB/taWTc7jEOEjz1cN8DlmOK6wEXi6pAesiWa/SASeFz0QquXp9mNxbl6ChB1q+c
         FR9toi6D92aUizGAKGiYklUroyemjADl3cOONpUyvRK/ERXFAmfAg6btb8WAIiwtwFJH
         EedVvt2hicoVtyUTF+N8jn16jB8PNSuGqyts/q4emnuCWyPLNjC0BQCVOo3XvBszivtU
         DdboDEGiDGlQtnsKmJ7fIwcBfFQ81pg7ovob6bjzcM97gOmFsDVXryhPjs7fFyWXipO9
         7fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683629530; x=1686221530;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYZR/G37tnsP7yUGSmNpBPI4OE2VINyICKexijTrIrs=;
        b=DpkQTjlA/jTuz0GnaU+22jwEIKcXP4WVC0yGgjPAse0sW6GdWrwHA4rRIQdc3R/opY
         cF/Fe0AgP+VxLH8GciZGpiS6thTIYy6qdzD7bWxKN0hXIwOPGI0gE4cBH1xNPs0EG+uo
         Y9PTWqSN97qVhXKuOYuPoIJuLQtzW4rn6aGR3SDcWpsGROCAURyUmmFt24t0FJHNkOGf
         fhJyu0jbPDVqOv+r+fuSmfcqDdmziBWQC2lfuXmRJ02/bL3xUmxrDfYTVBBBWibo4xqV
         5t5iOXFIOP5X/gX/VH7hpmI9uLIYzu5O/20AjI6OQ6wzrFQDffnv+vyx3Lkwl/6AglKn
         AR9A==
X-Gm-Message-State: AC+VfDz0Z8zPdFAdIZkBuBe2YMHPHghwJ2KdqiJ8x0qFhLpgKlEIgqsW
	7rq+8WxsU+gzqOL1ChTdbYqlTII6aaabWC+Nc4XlLkF7p62cvM1x
X-Google-Smtp-Source: ACHHUZ5ZZZZDp00tW12ttiwhEM7uxcDYGaxvO8tNi8qZw2H1kuoDRzZGcxLbksXpOIu4QWXT2X484i92J8Skpj0XXOs=
X-Received: by 2002:ac2:5fc8:0:b0:4ed:c3a1:752a with SMTP id
 q8-20020ac25fc8000000b004edc3a1752amr538611lfg.45.1683629530190; Tue, 09 May
 2023 03:52:10 -0700 (PDT)
MIME-Version: 1.0
From: Katu Txakur <katutxakurra@gmail.com>
Date: Tue, 9 May 2023 12:52:00 +0200
Message-ID: <CAM1ZcoXg6Sj7Y4Dd_7N3qFeKxqa5bktGP6G0JcG8qsL-aRN7DQ@mail.gmail.com>
Subject: [bitbake-devel] Perforce.py password with #
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000014969805fb408cd9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 10:52:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14768

--00000000000014969805fb408cd9
Content-Type: text/plain; charset="UTF-8"

Hi,

Using kirkstone branch, I've been trying to follow the Perforce
documentation in
https://docs.yoctoproject.org/bitbake/2.4/bitbake-user-manual/bitbake-user-manual-fetching.html#perforce-fetcher-p4
and I've created the following recipe:

#######################################
DESCRIPTION = "Perforce fetch test"
LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
FETCHCMD_p4 = "/usr/local/bin/p4"
P4PASSWD = "mypassword#"
P4PORT = "ssl:myserver:1666"
P4USER = "myuser"
P4DEPOT = "path_to_my_depot"

SRC_URI = "p4://${P4USER}:${P4PASSWD}@${P4DEPOT}/..."

PV = "p4-${SRCPV}"
S = "${WORKDIR}/p4"
######################################

I get the following error because my password finishes with a #:

user@pc:~/yocto/kirkstone/build$ bitbake  p4-test
/usr/lib/python3/dist-packages/html5lib/_trie/_base.py:3:
DeprecationWarning: Using or importing the ABCs from 'collections' instead
of from 'collections.abc' is deprecated since Python 3.3, and in 3.10 it
will stop working
  from collections import Mapping
Loading cache: 100%
|##########################################################################################################################################################################|
Time: 0:00:00
Loaded 1628 entries from dependency cache.
ERROR: /home/user/yocto/kirkstone/layers/meta-mylayer/recipes-custom/p4/
p4-test_0.1.bb: Error executing a python function in <code>:
                                        | ETA:  --:--:--

The stack trace of python calls that resulted in this exception/failure was:
File: '<code>', lineno: 3, function: <module>

 0001:__anon_20__home_user_yocto_kirkstone_poky_meta_conf_machine_include_arm_feature_arm_thumb_inc(d)

 0002:__anon_32__home_user_yocto_kirkstone_poky_meta_classes_patch_bbclass(d)
 ***
0003:__anon_762__home_user_yocto_kirkstone_poky_meta_classes_base_bbclass(d)

 0004:__anon_1135__home_user_yocto_kirkstone_poky_meta_classes_insane_bbclass(d)

 0005:__anon_1442__home_user_yocto_kirkstone_poky_meta_classes_insane_bbclass(d)

 0006:__anon_252__home_user_yocto_kirkstone_poky_meta_classes_package_bbclass(d)

 0007:__anon_723__home_user_yocto_kirkstone_poky_meta_classes_package_rpm_bbclass(d)
File: '/home/user/yocto/kirkstone/poky/meta/classes/base.bbclass', lineno:
635, function:
__anon_762__home_user_yocto_kirkstone_poky_meta_classes_base_bbclass
     0631:
     0632:    needsrcrev = False
     0633:    srcuri = d.getVar('SRC_URI')
     0634:    for uri_string in srcuri.split():
 *** 0635:        uri = bb.fetch.URI(uri_string)
     0636:        # Also check downloadfilename as the URL path might not
be useful for sniffing
     0637:        path = uri.params.get("downloadfilename", uri.path)
     0638:
     0639:        # HTTP/FTP use the wget fetcher
File: '/home/user/yocto/kirkstone/poky/bitbake/lib/bb/fetch2/__init__.py',
lineno: 253, function: __init__
     0249:            self.relative = True
     0250:
     0251:        if not self.relative:
     0252:            self.hostname = urlp.hostname or ''
 *** 0253:            self.port = urlp.port
     0254:
     0255:            self.userinfo += urlp.username or ''
     0256:
     0257:            if urlp.password:
File: '/usr/lib/python3.8/urllib/parse.py', lineno: 177, function: port
     0173:            try:
     0174:                port = int(port, 10)
     0175:            except ValueError:
     0176:                message = f'Port could not be cast to integer
value as {port!r}'
 *** 0177:                raise ValueError(message) from None
     0178:            if not ( 0 <= port <= 65535):
     0179:                raise ValueError("Port out of range 0-65535")
     0180:        return port
     0181:
Exception: ValueError: Port could not be cast to integer value as
'mypassword'

ERROR: Parsing halted due to errors, see error messages above

Summary: There were 2 ERROR messages, returning a non-zero exit code.

Note that in the Exception, the ValueError tries to parse my password,
without the # as the port number.

Thanks,
Katu

--00000000000014969805fb408cd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Using kirkstone branch, =
I&#39;ve been trying to follow the Perforce documentation in <a href=3D"htt=
ps://docs.yoctoproject.org/bitbake/2.4/bitbake-user-manual/bitbake-user-man=
ual-fetching.html#perforce-fetcher-p4">https://docs.yoctoproject.org/bitbak=
e/2.4/bitbake-user-manual/bitbake-user-manual-fetching.html#perforce-fetche=
r-p4</a> and I&#39;ve created the following recipe:</div><div><br></div><di=
v>#######################################<br></div><div>DESCRIPTION =3D &qu=
ot;Perforce fetch test&quot;<br>LICENSE =3D &quot;CLOSED&quot;<br><br>SRCRE=
V =3D &quot;${AUTOREV}&quot;<br>FETCHCMD_p4 =3D &quot;/usr/local/bin/p4&quo=
t;<br>P4PASSWD =3D &quot;mypassword#&quot;<br>P4PORT =3D &quot;ssl:myserver=
:1666&quot;<br>P4USER =3D &quot;myuser&quot;<br>P4DEPOT =3D &quot;path_to_m=
y_depot&quot;<br><br>SRC_URI =3D &quot;p4://${P4USER}:${P4PASSWD}@${P4DEPOT=
}/...&quot;<br><br>PV =3D &quot;p4-${SRCPV}&quot;<br>S =3D &quot;${WORKDIR}=
/p4&quot;</div><div>######################################</div><div><br></=
div><div>I get the following error because my password finishes with a #:</=
div><div><br></div><div>user@pc:~/yocto/kirkstone/build$ bitbake =C2=A0p4-t=
est<br>/usr/lib/python3/dist-packages/html5lib/_trie/_base.py:3: Deprecatio=
nWarning: Using or importing the ABCs from &#39;collections&#39; instead of=
 from &#39;collections.abc&#39; is deprecated since Python 3.3, and in 3.10=
 it will stop working<br>=C2=A0 from collections import Mapping<br>Loading =
cache: 100% |##############################################################=
###########################################################################=
#################################| Time: 0:00:00<br>Loaded 1628 entries fro=
m dependency cache.<br>ERROR: /home/user/yocto/kirkstone/layers/meta-mylaye=
r/recipes-custom/p4/<a href=3D"http://p4-test_0.1.bb">p4-test_0.1.bb</a>: E=
rror executing a python function in &lt;code&gt;: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | ETA: =C2=A0--:--:--<br><br>The stack trace of python ca=
lls that resulted in this exception/failure was:<br>File: &#39;&lt;code&gt;=
&#39;, lineno: 3, function: &lt;module&gt;<br>=C2=A0 =C2=A0 =C2=A00001:__an=
on_20__home_user_yocto_kirkstone_poky_meta_conf_machine_include_arm_feature=
_arm_thumb_inc(d)<br>=C2=A0 =C2=A0 =C2=A00002:__anon_32__home_user_yocto_ki=
rkstone_poky_meta_classes_patch_bbclass(d)<br>=C2=A0*** 0003:__anon_762__ho=
me_user_yocto_kirkstone_poky_meta_classes_base_bbclass(d)<br>=C2=A0 =C2=A0 =
=C2=A00004:__anon_1135__home_user_yocto_kirkstone_poky_meta_classes_insane_=
bbclass(d)<br>=C2=A0 =C2=A0 =C2=A00005:__anon_1442__home_user_yocto_kirksto=
ne_poky_meta_classes_insane_bbclass(d)<br>=C2=A0 =C2=A0 =C2=A00006:__anon_2=
52__home_user_yocto_kirkstone_poky_meta_classes_package_bbclass(d)<br>=C2=
=A0 =C2=A0 =C2=A00007:__anon_723__home_user_yocto_kirkstone_poky_meta_class=
es_package_rpm_bbclass(d)<br>File: &#39;/home/user/yocto/kirkstone/poky/met=
a/classes/base.bbclass&#39;, lineno: 635, function: __anon_762__home_user_y=
octo_kirkstone_poky_meta_classes_base_bbclass<br>=C2=A0 =C2=A0 =C2=A00631:<=
br>=C2=A0 =C2=A0 =C2=A00632: =C2=A0 =C2=A0needsrcrev =3D False<br>=C2=A0 =
=C2=A0 =C2=A00633: =C2=A0 =C2=A0srcuri =3D d.getVar(&#39;SRC_URI&#39;)<br>=
=C2=A0 =C2=A0 =C2=A00634: =C2=A0 =C2=A0for uri_string in srcuri.split():<br=
>=C2=A0*** 0635: =C2=A0 =C2=A0 =C2=A0 =C2=A0uri =3D bb.fetch.URI(uri_string=
)<br>=C2=A0 =C2=A0 =C2=A00636: =C2=A0 =C2=A0 =C2=A0 =C2=A0# Also check down=
loadfilename as the URL path might not be useful for sniffing<br>=C2=A0 =C2=
=A0 =C2=A00637: =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D uri.params.get(&quot;do=
wnloadfilename&quot;, uri.path)<br>=C2=A0 =C2=A0 =C2=A00638:<br>=C2=A0 =C2=
=A0 =C2=A00639: =C2=A0 =C2=A0 =C2=A0 =C2=A0# HTTP/FTP use the wget fetcher<=
br>File: &#39;/home/user/yocto/kirkstone/poky/bitbake/lib/bb/fetch2/__init_=
_.py&#39;, lineno: 253, function: __init__<br>=C2=A0 =C2=A0 =C2=A00249: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.relative =3D True<br>=C2=A0 =C2=
=A0 =C2=A00250:<br>=C2=A0 =C2=A0 =C2=A00251: =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
not self.relative:<br>=C2=A0 =C2=A0 =C2=A00252: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0self.hostname =3D urlp.hostname or &#39;&#39;<br>=C2=A0*** 02=
53: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.port =3D urlp.port<br>=C2=
=A0 =C2=A0 =C2=A00254:<br>=C2=A0 =C2=A0 =C2=A00255: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0self.userinfo +=3D urlp.username or &#39;&#39;<br>=C2=
=A0 =C2=A0 =C2=A00256:<br>=C2=A0 =C2=A0 =C2=A00257: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if urlp.password:<br>File: &#39;/usr/lib/python3.8/urll=
ib/parse.py&#39;, lineno: 177, function: port<br>=C2=A0 =C2=A0 =C2=A00173: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>=C2=A0 =C2=A0 =C2=A00174: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D int(port, 1=
0)<br>=C2=A0 =C2=A0 =C2=A00175: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ex=
cept ValueError:<br>=C2=A0 =C2=A0 =C2=A00176: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0message =3D f&#39;Port could not be cast to inte=
ger value as {port!r}&#39;<br>=C2=A0*** 0177: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0raise ValueError(message) from None<br>=C2=A0 =
=C2=A0 =C2=A00178: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ( 0 &lt;=
=3D port &lt;=3D 65535):<br>=C2=A0 =C2=A0 =C2=A00179: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise ValueError(&quot;Port out of range =
0-65535&quot;)<br>=C2=A0 =C2=A0 =C2=A00180: =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn port<br>=C2=A0 =C2=A0 =C2=A00181:<br>Exception: ValueError: Port could n=
ot be cast to integer value as &#39;mypassword&#39;<br><br>ERROR: Parsing h=
alted due to errors, see error messages above<br><br>Summary: There were 2 =
ERROR messages, returning a non-zero exit code.</div><div><br></div><div>No=
te that in the Exception, the ValueError tries to parse my password, withou=
t the # as the port number.</div><div><br></div><div>Thanks,</div><div>Katu=
<br></div></div>

--00000000000014969805fb408cd9--

