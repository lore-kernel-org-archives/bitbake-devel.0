Return-Path: <otavio.salvador@ossystems.com.br>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC78D30CDB
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 00:03:06 +0000 (UTC)
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73370.1768348983586991917
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Jan 2026 16:03:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ossystems.com.br header.s=os header.b=nXcykZH/;
 spf=pass (domain: ossystems.com.br, ip: 209.85.216.65, mailfrom: otavio.salvador@ossystems.com.br)
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4774561a91.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems.com.br; s=os; t=1768348982; x=1768953782; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56HJq3xP8djbfM/YwUo/sIofGm6znYjppFDERrWcEag=;
        b=nXcykZH/WH0nO9hGLKaefgSn4fsm6maTayWS2cg/0aj6gOxkMoPZEwTOyH7jbueNwu
         bzfl2RMrhQTMUaEu9nORfBK6nXyyQbopHGwH6ESziOpzp8ihwJOmuLeV4PUTurCKS/PO
         KeVsLNc93YQm33yj83FRKEj4lXXbDGIXjHqJZd7kc7b/DZQ1BudkzHtVZZxDbM4ppQuU
         94apUmuXxJH91gZq5rnOWLyPaYjMO3LLJ9Bvo5HyN6Oty3eDEKHa/BPsxALsb/ge+iKp
         MLZB7ArsDuQ0TKEVOOSONgPs0ke55sV2lUY6fnhouEgRgpXAG3qxjqwER4xYDihXwFAN
         ggCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768348982; x=1768953782;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56HJq3xP8djbfM/YwUo/sIofGm6znYjppFDERrWcEag=;
        b=bfEF8CgtRk2J8SF/mGeUAIQGcq2SeHAL+C6oSeMXPbEV5q0bG94anwBSPJ0Afr2OhT
         xRSG0GaoAhgq0ly2r+m5FEKEH2tZj+c8TCXtr10ckb050sIy2PqaXjC+es7yigRISm8U
         kC4rReXRPlmzSK++pKBqzX6h4T6BIfv03RUQ4Whjxlrf2Y1PQ1ns1d8C11TkomHaQXkS
         Cs43LHBPVq3yJyzuiuhQC/OtullopNpwyDvOZ+fxauynHD8qJIbOW2Okvx+Z025jtKfk
         JuRwDf+kwxjGrXVlDRAPetDGJKHXEKiFZTsSptfto+0tSogwAh48tRH1py5QDaHJ8Ypr
         ysIA==
X-Gm-Message-State: AOJu0Yzy26tXB2+rDjLbJGRW2KFDFHw5lr1KgVfvX6FgKNIDB0T3LDYQ
	9eS3BrIN3AHuKeO7iwXyBELA7Yo2fMPFK40Hhgy28r6/Eg6SWX9+QGBOO4HyXVrWp7Y6DN8kbPn
	HaeJRNwE/uQ==
X-Gm-Gg: AY/fxX7jfTg504h55DWxT+d1H2xSifkSCADCUIgbepbRZcwfsw4j+zsbq227WrIrrZI
	tj2qp7/K9X1kVfFjnQ+SgMlGf3FDbJfi61Rocb3HXuTi1KDapP8oDbjVgzz+UzMStHOioGjPS5C
	59CEc9Zh2KWPQF3NNbHhgQ7i3ei4d4t6xANhQ3WpxUoCvWdNgNkw1pPcN6h5PTusi7g1XQg9KuO
	Rs7trqDHEiQb+C/++PGgrFQ+qHas6UDf44bRa8BK2kuR8TJ8xsfAD6itAB0qthuhSmAOi7bUKdS
	uFqDqQhRV/fW7YhlqQCAqA6acg6t8ke/A8i10yCOBotYn6XAamT1S+xsI3YqFce+SnSCpAhowSO
	9CXGolVMxSoepmoECrvLRSSoa+UeRbQo/LMhv71e1GEXHF7mYZyVetPL6Kh40uxqWXC2eGzySd9
	WhwtalEil71nxzogOoi7TSpKIp7RhMOccsTRukGrnzaKEFuGMA+yd/lPsPhIZ1YfJR
X-Received: by 2002:a17:90b:2c90:b0:349:2136:83eb with SMTP id 98e67ed59e1d1-35109135094mr778804a91.29.1768348982134;
        Tue, 13 Jan 2026 16:03:02 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109e7ee68sm195294a91.17.2026.01.13.16.03.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 16:03:01 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c213f7690so5394373a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 16:03:01 -0800 (PST)
X-Received: by 2002:a17:90a:d405:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-3510915b515mr812143a91.33.1768348980821; Tue, 13 Jan 2026
 16:03:00 -0800 (PST)
MIME-Version: 1.0
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
Date: Tue, 13 Jan 2026 21:02:49 -0300
X-Gmail-Original-Message-ID: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
X-Gm-Features: AZwV_Qj-_Q67KWxxEmyD78Ia3UWnE1QcaaVNUAzabwtnk8vS-RnrCKBn1sgjbbs
Message-ID: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
Subject: [RFC] bitbake-setup: Documentation terminology and tooling suggestions
To: bitbake-devel@lists.openembedded.org, 
	Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d7496206484dd4b1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 00:03:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18746

--000000000000d7496206484dd4b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

We are currently working on the fourth edition of our Yocto Project book
and have been updating the content from Yocto Project 4.0 to the upcoming
6.0 release. As part of this effort, we have been working extensively with
the new bitbake-setup tool and its documentation.

First, we would like to say that bitbake-setup is a welcome addition to the
ecosystem. The move from the monolithic Poky repository approach to a more
modular, template-based setup is a significant improvement for flexibility
and reproducibility.

During our work, we identified some areas where we believe the
documentation and tooling could be improved to make the experience smoother
for newcomers. We are sharing these observations in the hope of starting a
constructive conversation.
Terminology Suggestions

The current documentation introduces several new terms that we found
challenging to communicate clearly to readers. We would like to propose
some alternative naming that we believe would be more intuitive.
1. Generic Configuration =E2=86=92 BitBake Setup Template

The term "Generic Configuration" does not immediately convey that this is a
reusable template file used as input to create a build environment. The
word "generic" can be interpreted as "basic" or "non-specialized" rather
than "reusable template."

We suggest *BitBake Setup Template* as an alternative. This clearly
communicates that the .conf.json file serves as a template for creating
setups.
2. Specific Configuration =E2=86=92 BitBake Setup Instance

Similarly, "Specific Configuration" does not clearly indicate that this is
the *result* of applying a template with user choices. The relationship
between "Generic" and "Specific" is not immediately obvious.

We suggest *BitBake Setup Instance* as an alternative. The "Template =E2=86=
=92
Instance" pattern is widely understood by developers and immediately
conveys the relationship: a template is used to create an instance.
3. Nested "configurations" =E2=86=92 Variant

Within a BitBake Setup Template, there are nested "configurations" (e.g.,
poky, poky-with-sstate) that represent predefined bundles of fragments and
settings. Using "configuration" here creates confusion since the term is
already heavily overloaded in the Yocto ecosystem.

We suggest *Variant* as an alternative. This conveys that these are
different flavors or variations of the same base template, similar to how
distributions have variants or flavors.
Summary Table
Current Term Proposed Term
Generic Configuration BitBake Setup Template
Specific Configuration BitBake Setup Instance
(nested) configurations Variant
Tooling and Usability Feedback 1. pip-installed bitbake-setup Cannot Access
Default Registries

When installing bitbake-setup via pip and running bitbake-setup init, the
command fails because it cannot locate the default registry files that
would normally be at ./bitbake/default-registry/.

This creates a confusing first experience for users who expect a
pip-installed tool to work out of the box. Having to clone the full BitBake
repository defeats the convenience of pip installation.
2. Allow Empty Variants in Templates

Currently, bitbake-setup init requires the user to select a variant when
one is defined in the template. There is no option to skip this selection.

Allowing templates without variants (or making variant selection optional)
would reduce the number of questions during setup, making the process
faster and more approachable for newcomers.
3. Unclear Error When Using Non-Raw URLs

When running bitbake-setup init with a URL to a .conf.json file hosted on
platforms like GitHub or GitLab, users naturally copy the URL from their
browser. This URL points to an HTML page rather than the raw JSON content,
causing the command to fail.

The error message does not clearly indicate that a raw/plain URL is
required. A clearer error message or guidance would help users understand
the issue more quickly.
4. Tool to Generate Templates from Existing Environments

Currently, there is no way to generate a BitBake Setup Template from:

   - An existing BitBake Setup Instance
   - A traditional workspace set up manually with oe-init-build-env
   - Any working Yocto/OpenEmbedded build environment

A tool to export a working environment as a template would:

   - Help users migrate existing projects to the new bitbake-setup workflow
   - Make it easier to share working configurations with colleagues or the
   community
   - Reduce the barrier to adoption for users with established projects

5. Fragment Discovery on OpenEmbedded Layer Index

The OpenEmbedded Layer Index (https://layers.openembedded.org) is an
excellent resource for discovering layers. However, there is no equivalent
discovery mechanism for configuration fragments.

Adding a tab or section for fragments would help users discover available
fragments and understand what problems they solve.
------------------------------

We hope this feedback is helpful. We are happy to discuss any of these
points further or assist with documentation improvements.

Best regards,

Ot=C3=A1vio Salvador

Daiane Angolini

--=20
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854

--000000000000d7496206484dd4b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><h1><span style=3D"font-size:small;font-weight:normal=
">Hello everyone,</span></h1>
<p>We are currently working on the fourth edition of our Yocto Project book=
 and have been updating the content from Yocto Project 4.0 to the upcoming =
6.0 release. As part of this effort, we have been working extensively with =
the new <code>bitbake-setup</code> tool and its documentation.</p>
<p>First, we would like to say that <code>bitbake-setup</code> is a welcome=
 addition to the ecosystem. The move from the monolithic Poky repository ap=
proach to a more modular, template-based setup is a significant improvement=
 for flexibility and reproducibility.</p>
<p>During our work, we identified some areas where we believe the documenta=
tion and tooling could be improved to make the experience smoother for newc=
omers. We are sharing these observations in the hope of starting a construc=
tive conversation.</p>
<h2>Terminology Suggestions</h2>
<p>The current documentation introduces several new terms that we found cha=
llenging to communicate clearly to readers. We would like to propose some a=
lternative naming that we believe would be more intuitive.</p>
<h3>1. Generic Configuration =E2=86=92 BitBake Setup Template</h3>
<p>The term &quot;Generic Configuration&quot; does not immediately convey t=
hat this is a reusable template file used as input to create a build enviro=
nment. The word &quot;generic&quot; can be interpreted as &quot;basic&quot;=
 or &quot;non-specialized&quot; rather than &quot;reusable template.&quot;<=
/p>
<p>We suggest <strong>BitBake Setup Template</strong> as an alternative. Th=
is clearly communicates that the <code>.conf.json</code> file serves as a t=
emplate for creating setups.</p>
<h3>2. Specific Configuration =E2=86=92 BitBake Setup Instance</h3>
<p>Similarly, &quot;Specific Configuration&quot; does not clearly indicate =
that this is the <em>result</em> of applying a template with user choices. =
The relationship between &quot;Generic&quot; and &quot;Specific&quot; is no=
t immediately obvious.</p>
<p>We suggest <strong>BitBake Setup Instance</strong> as an alternative. Th=
e &quot;Template =E2=86=92 Instance&quot; pattern is widely understood by d=
evelopers and immediately conveys the relationship: a template is used to c=
reate an instance.</p>
<h3>3. Nested &quot;configurations&quot; =E2=86=92 Variant</h3>
<p>Within a BitBake Setup Template, there are nested &quot;configurations&q=
uot; (e.g., <code>poky</code>, <code>poky-with-sstate</code>) that represen=
t predefined bundles of fragments and settings. Using &quot;configuration&q=
uot; here creates confusion since the term is already heavily overloaded in=
 the Yocto ecosystem.</p>
<p>We suggest <strong>Variant</strong> as an alternative. This conveys that=
 these are different flavors or variations of the same base template, simil=
ar to how distributions have variants or flavors.</p>
<h3>Summary Table</h3>
<table>
<thead>
<tr>
<th>Current Term</th>
<th>Proposed Term</th>
</tr>
</thead>
<tbody>
<tr>
<td>Generic Configuration</td>
<td>BitBake Setup Template</td>
</tr>
<tr>
<td>Specific Configuration</td>
<td>BitBake Setup Instance</td>
</tr>
<tr>
<td>(nested) configurations</td>
<td>Variant</td>
</tr>
</tbody>
</table>
<h2><br></h2><h2>Tooling and Usability Feedback</h2>
<h3>1. pip-installed bitbake-setup Cannot Access Default Registries</h3>
<p>When installing <code>bitbake-setup</code> via pip and running <code>bit=
bake-setup init</code>, the command fails because it cannot locate the defa=
ult registry files that would normally be at <code>./bitbake/default-regist=
ry/</code>.</p>
<p>This creates a confusing first experience for users who expect a pip-ins=
talled tool to work out of the box. Having to clone the full BitBake reposi=
tory defeats the convenience of pip installation.</p>
<h3>2. Allow Empty Variants in Templates</h3>
<p>Currently, <code>bitbake-setup init</code> requires the user to select a=
 variant when one is defined in the template. There is no option to skip th=
is selection.</p>
<p>Allowing templates without variants (or making variant selection optiona=
l) would reduce the number of questions during setup, making the process fa=
ster and more approachable for newcomers.</p>
<h3>3. Unclear Error When Using Non-Raw URLs</h3>
<p>When running <code>bitbake-setup init</code> with a URL to a <code>.conf=
.json</code> file hosted on platforms like GitHub or GitLab, users naturall=
y copy the URL from their browser. This URL points to an HTML page rather t=
han the raw JSON content, causing the command to fail.</p>
<p>The error message does not clearly indicate that a raw/plain URL is requ=
ired. A clearer error message or guidance would help users understand the i=
ssue more quickly.</p>
<h3>4. Tool to Generate Templates from Existing Environments</h3>
<p>Currently, there is no way to generate a BitBake Setup Template from:</p=
>
<ul>
<li>An existing BitBake Setup Instance</li>
<li>A traditional workspace set up manually with <code>oe-init-build-env</c=
ode></li>
<li>Any working Yocto/OpenEmbedded build environment</li>
</ul>
<p>A tool to export a working environment as a template would:</p>
<ul>
<li>Help users migrate existing projects to the new <code>bitbake-setup</co=
de> workflow</li>
<li>Make it easier to share working configurations with colleagues or the c=
ommunity</li>
<li>Reduce the barrier to adoption for users with established projects</li>
</ul>
<h3>5. Fragment Discovery on OpenEmbedded Layer Index</h3>
<p>The OpenEmbedded Layer Index (<a href=3D"https://layers.openembedded.org=
">https://layers.openembedded.org</a>) is an excellent resource for discove=
ring layers. However, there is no equivalent discovery mechanism for config=
uration fragments.</p>
<p>Adding a tab or section for fragments would help users discover availabl=
e fragments and understand what problems they solve.</p>
<hr>
<p>We hope this feedback is helpful. We are happy to discuss any of these p=
oints further or assist with documentation improvements.</p>
<p>Best regards,</p>
<p>Ot=C3=A1vio Salvador=C2=A0</p><p>Daiane Angolini</p></div><div><br></div=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">O=
tavio Salvador =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O.S. Systems<br><a href=3D"http://ww=
w.ossystems.com.br" target=3D"_blank">http://www.ossystems.com.br</a> =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://code.ossystems.com.br" target=3D"=
_blank">http://code.ossystems.com.br</a><br>Mobile: +55 (53) 9 9981-7854</d=
iv></div></div>

--000000000000d7496206484dd4b1--

