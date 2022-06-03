Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CBC433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 10:20:16 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by mx.groups.io with SMTP id smtpd.web08.5620.1654251613866072821
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 03:20:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=Y9vwhJsP;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.19,
 mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5CC97320094D;
	Fri,  3 Jun 2022 06:20:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Jun 2022 06:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1654251609; x=1654338009; bh=1M
	xSM3WTL8Lq34lk9yiIc+Lo9YapgbPZVln/nHNHV9k=; b=Y9vwhJsP472Lha09kw
	vLkEknR6e6MoknBhM62Xxt2jq2qxIoy3K7Z3Utr/6y+sSgxN8vub7wgWZ0hFVl4z
	Wqoemc9Ffp5GY6fJIIIYwomi3Wki3SLlvsTHxK+o+NDBc/rAoAR52RRFOJyMnopR
	62JmWOY1aMZoNtIZBC9dkuviXsBMgCwJaFdgZdS/vepk7LhOCyhlSgBM93vZgW2H
	fTTv7vj+uTlfBHi2+0YHOZRBmQ+Ds18FE6S1y0azwIPmt7RbPBr3dzo5OLiFrzS9
	J557ATVER1U3sYaFd1VoEtyCs2iRQZFpZwOfdAWs1/kzihOfYYiaKoURsLr4H0sH
	4wPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1654251609; x=1654338009; bh=1MxSM3WTL8Lq3
	4lk9yiIc+Lo9YapgbPZVln/nHNHV9k=; b=f9ibNbeYkLUI+fVvaodBikpN8/epu
	0GegY2GY6eiiUAIGsJ+fHieml8uK3UleTJb78XnoiUHWbxKDjMZaLntmpDu1bwGq
	a9EtXK34lHHK3XTGzdWhZpcmEEX8csCy92QKq06poAP6rAy47+uTfP6LdgZQ/1PR
	JK4DmvhBrWYNgHPp3Espwu9iGyEgUux+FVKfHuRwr70mZoksuhkw+7+3FWHUP5N/
	VpjNkuhhsEMbvq3n1ADNZJ+5I0BfLS2awZz3QFasGShjz8ZcJlqjYd2H3/RyseWo
	ZF4kBQeOk1F61Uix3xlT1AeCFceMAGLEaoLbvClcBQ10FoKjOUrhZz2Og==
X-ME-Sender: <xms:WeCZYlOVic8RJX-DKy6alP9CAn_nq7Xjcef86nxPiKyXjgyBKZsO-g>
    <xme:WeCZYn9CN-TXxTR8Y1a617XYf9T7BI_7I6xvZNtOajwggOBZ9dnEV-tAo27I-Htg2
    lXTcZkJhoIErfk1sZ8>
X-ME-Received: 
 <xmr:WeCZYkTCuTdiWS4yelAAcBJe5QPneX88xfBs2i8xtVKOxmn68x17zdYdbT1rZt8MxN431q4>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrleeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffrhgjkfggtgesthdtredttdertdenucfhrhhomheprfgrvhgv
    lhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrfgrth
    htvghrnhepkedtueegheduueekkeeuveehledvffekueehtdfgtedvteefleelgeekgeeg
    ueegnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhho
    fhhfrdhnvght
X-ME-Proxy: <xmx:WeCZYhs7NPKmI8A3Euh7OucCLkZrzgQvTXwb9V9_Jf3rgIokROeKcQ>
    <xmx:WeCZYtcwfzAwOdDFqFXna99ExZRXyz3TUtRi8sQLi9mNtjgXc48O1w>
    <xmx:WeCZYt2RI-XrrE-ZP1ZUDzSoQtp5g9j1jdRSBKOV5umBrqsbyyTxbQ>
    <xmx:WeCZYtFurxTiWfnGXOhkLpp2u9oj79rmROO2UBsAyfrZuT_MUEO15w>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 06:20:08 -0400 (EDT)
References: <20220603094651.22816-1-jacob.kroon@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Pavel Zhukov <pavel@zhukoff.net>
To: Jacob Kroon <jacob.kroon@gmail.com>
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Correct
 description of the ??= operator
Date: Fri, 03 Jun 2022 12:16:53 +0200
Reply-To: pavel@zhukoff.net
In-reply-to: <20220603094651.22816-1-jacob.kroon@gmail.com>
Message-ID: <87sfomf3qx.fsf@gentoo.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jun 2022 10:20:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13729


IMO the example with ":=" should go under "immediately variable expantion" section.
The change mentions operator which has not been
described earlier and this may be confusing for the person who reads the
manual for the first time.

-- Pavel

"Jacob Kroon" <jacob.kroon@gmail.com> writes:

> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>  .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index af4b1358..1c146f0f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is set to "aval".
>  Setting a weak default value (??=)
>  ----------------------------------
>  
> -It is possible to use a "weaker" assignment than in the previous section
> -by using the "??=" operator. This assignment behaves identical to "?="
> -except that the assignment is made at the end of the parsing process
> -rather than immediately. Consequently, when multiple "??=" assignments
> -exist, the last one is used. Also, any "=" or "?=" assignment will
> -override the value set with "??=". Here is an example::
> -
> -   A ??= "somevalue"
> -   A ??= "someothervalue"
> -
> -If ``A`` is set before the above statements are
> -parsed, the variable retains its value. If ``A`` is not set, the
> -variable is set to "someothervalue".
> -
> -Again, this assignment is a "lazy" or "weak" assignment because it does
> -not occur until the end of the parsing process.
> +The weak default value of a variable is the value which that variable
> +will expand to if no value has been assigned to it via one of the other
> +assignment operators. Here is an example::
> +
> +   W ??= "x"
> +   A := "${W}"
> +   W ??= "y"
> +   B = "${W}"
> +   W ?= "z"
> +
> +After parsing we will have::
> +
> +   A = "x"
> +   B = "z"
> +   W = "z"
>  
>  Immediate variable expansion (:=)
>  ---------------------------------
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13728): https://lists.openembedded.org/g/bitbake-devel/message/13728
> Mute This Topic: https://lists.openembedded.org/mt/91517826/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
> -=-=-=-=-=-=-=-=-=-=-=-


