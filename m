Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E608FED2F7
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 09:09:07 +0000 (UTC)
Subject: Re: [PATCH 1/1] utils: add is_enabled function
To: bitbake-devel@lists.openembedded.org
From: "Michal Sieron" <michalwsieron@gmail.com>
X-Originating-Location: Frankfurt am Main, Hesse, DE (136.226.162.91)
X-Originating-Platform: Linux Firefox 148
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 12 Mar 2026 02:09:03 -0700
References: <20260311131917.2203296-1-pierre-loup.gosse@smile.fr> <fc5468c04fc393f098ffeb1ea37c4332587ddd59.camel@linuxfoundation.org>
In-Reply-To: <fc5468c04fc393f098ffeb1ea37c4332587ddd59.camel@linuxfoundation.org>
Message-ID: <146381.1773306543289644043@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="bu7ORqPMF0rJNj2figqK"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 09:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19148

--bu7ORqPMF0rJNj2figqK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Isn't this identical to `oe.utils.vartrue()` anyway?

```
def vartrue(var, iftrue, iffalse, d):
import oe.types
if oe.types.boolean(d.getVar(var)):
return iftrue
else:
return iffalse
```

Br,
Michal

--bu7ORqPMF0rJNj2figqK
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Isn't this identical to `oe.utils.vartrue()` anyway?</div>
<div>&nbsp;</div>
<div>```</div>
<div>def vartrue(var, iftrue, iffalse, d):<br />&nbsp; &nbsp; import oe.typ=
es<br />&nbsp; &nbsp; if oe.types.boolean(d.getVar(var)):<br />&nbsp; &nbsp=
; &nbsp; &nbsp; return iftrue<br />&nbsp; &nbsp; else:<br />&nbsp; &nbsp; &=
nbsp; &nbsp; return iffalse</div>
<div>```</div>
<div>&nbsp;</div>
<div>Br,</div>
<div>Michal</div>

--bu7ORqPMF0rJNj2figqK--

