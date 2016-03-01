Return-Path: <lucas.dutra.nunes@gmail.com>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.161.195])
	by mail.openembedded.org (Postfix) with ESMTP id CE34D7317E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 13:17:11 +0000 (UTC)
Received: by mail-yw0-f195.google.com with SMTP id h80so9299726ywc.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Mar 2016 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc; bh=Z5c6U5A0Va1T7TzOgqAEeOinBxcC83CnYh/PoYyXBYI=;
	b=xD28lmj0z5upUK2WbvxWr1BjNARUo1EWcccJz6z2fnEuw1P/KEhzJVuSxGZ3VXpgRw
	ELITfz9zBTtKFP+CdzX6B3VpmgmGWm9VSv4N5WlEMVk+00GTpJmVVFCM1Ac+khymgmhj
	occS8JsXU5UVKyoQyTbYLQrZMq5PGtnhSrFEd3w9Iswo7cx0IrEaxLnQi5GLo1Fc4+Bp
	YjBikcvBM0e1iOosG4OWTWGvydviifdGQVTYWrS6d9iX5/9WtYgl3FipWaOUNROt7esT
	0pAWbPDvVdH/eU/WeNkCfyM6GbkW9auiUCfTRnhAhec6F2Xx8OJ9StANyLtGLSM+XJl9
	fOHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc; bh=Z5c6U5A0Va1T7TzOgqAEeOinBxcC83CnYh/PoYyXBYI=;
	b=Z5b8+Hd5S4Co8H3qk+fd2NbTe0wPG0wOQ8gazxvpn2RiEIw1xvdSEXksy+4sVeoN3T
	/hk9T31M+QqXNoJOUVqt181bM7RzBAVvpduoMh3uHspdbnUoEwGxSjoLwkhnDFthmklq
	EL6u2+Ewavyji+VZkUtiVmpJWtVQwzbmZ+Xq6EkkNqGlmBuGWPG4cW/utx1+7IUC69AD
	XhMpW8x4S9R5d/zBeVZgVH8iCRUMP/9pxLEX47GbMCTJnAYNZXq9fqXDZ0cx8L7fdvc4
	Iu7Wc+YYY0/aE1qeLF1bPo5jGYalBJ6rymG012r6vW718s+dsMzz4yboiQH1yT8e4LI0
	Etaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=Z5c6U5A0Va1T7TzOgqAEeOinBxcC83CnYh/PoYyXBYI=;
	b=DaxQHnWwEGBXWysaIZ3aXw8g4m/DfBV5WqlY5YoSpbTphhiR8dwpJlZ7HgvCPONs96
	vPine4a0utbP4BdQsvtoVmZm9lFG9znDvz7DhcWIKAWEkHNWdc8U8dp21bjqRjnlExpG
	shNBP5XgeXWHGL6+fWMro8z7i0NA6OpAE+IEhUPEhN7LEUN2sOSV87fdIfRxb504M6Gt
	ubTArdOaASLzrV2BykLME6zvXuTt4EGQv393MHJ7eSF1EzmkTjbYpL90wBae45OdVuFg
	gZ/2w1a48r7IfT8QdLnF6YVFwns3UILN38EeYZKvT4Pn02JqF0fBV1m1d/aN8CM/vWWS
	vFEA==
X-Gm-Message-State: AD7BkJL9oCVETSbdVo9zsOADZdlZ1LBGxsGZNiIOMtaNgLirCASuozaJ2JwD0rR8O4HpHihY2SgfmhylIrwyDA==
MIME-Version: 1.0
X-Received: by 10.129.91.6 with SMTP id p6mr11061074ywb.325.1456838232215;
	Tue, 01 Mar 2016 05:17:12 -0800 (PST)
Sender: lucas.dutra.nunes@gmail.com
Received: by 10.129.147.65 with HTTP; Tue, 1 Mar 2016 05:17:12 -0800 (PST)
In-Reply-To: <1456838014-9941-1-git-send-email-ldnunes@ossystems.com.br>
References: <1456838014-9941-1-git-send-email-ldnunes@ossystems.com.br>
Date: Tue, 1 Mar 2016 10:17:12 -0300
X-Google-Sender-Auth: O2ZjqlAPyZUty6RJdM5HU7_4_IQ
Message-ID: <CABLrhkj5vJj8O2LDmZE8k7n33g+Lj=3rfbEbrKiGTamEEZXbhQ@mail.gmail.com>
From: Lucas Nunes <ldnunes@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 07 Mar 2016 17:22:11 +0000
Cc: Lucas Dutra Nunes <ldnunes@ossystems.com.br>
Subject: Re: [Documentation][PATCH v1] Server comm: try connecting 4 times before giving up
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
X-List-Received-Date: Tue, 01 Mar 2016 13:17:13 -0000
Content-Type: multipart/alternative; boundary=001a114c888c539e31052cfc9568

--001a114c888c539e31052cfc9568
Content-Type: text/plain; charset=UTF-8

Please ignore the [Documentation] tag, I forgot to remove it.

-- 
Lucas Dutra Nunes

--001a114c888c539e31052cfc9568
Content-Type: text/html; charset=UTF-8

<div dir="ltr">Please ignore the [Documentation] tag, I forgot to remove it.<br><div><div class="gmail_extra"><br>-- <br><div class="gmail_signature">Lucas Dutra Nunes</div>
</div></div></div>

--001a114c888c539e31052cfc9568--
