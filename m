Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id C2D56770CA
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 14:33:39 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id i6so987309pfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Aug 2016 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:from:in-reply-to:date:cc:message-id:references
	:to; bh=G8koK1Ifs0xO8KYfPRzoP7ovZIizmDHrxL3ibuwahBQ=;
	b=E0+XwOlwu4dCmyYpdGFmrozYWudoUGXIFzzKgQxRwKOwzcWHQA8ijaW+vANwqm2XcX
	OPolIo1GzLMexe/NWQ2JAu+lSLd4k+Nm2Jg8KBZYkZfsTJFM0pCaL8UOX9PcPc2XP6k8
	JzaOrce88umbsVL3ct+BLD4s+T5odVWJBnHCeixInpU0d9aiQSEDou882a0cP6vAaLGB
	GV1naesUIyj3QTpTXXFpQ5tw1TrE+HFdY8UriVQAGI5u9PiYM0JAkWwiF+z5Pxt8FGxz
	qju0ogY/OPLsYQ0EweObvy/vWFn64ef383SpjH5Eqn5DXexSRCLYrCil85j7I+ukhSZH
	f/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=G8koK1Ifs0xO8KYfPRzoP7ovZIizmDHrxL3ibuwahBQ=;
	b=iZY880hZOIJI3l7OC0E8WsxOUJBDSg+TIizDYfSM7wSbQavf3FjgE4PQJbSvdJqXwm
	JT6DBsMCqzuPBprt7ugdPPXSYO94I0LQfz98MwMp9vee1ThZ9CYzJMnojn8m+1KwHieA
	/zzXhxW2JWJb1p/42RJDCUuA/tQuXZzndjl7FjHExkxIcOxUt+EkrAiBybDA9N5yTNpk
	Ldi7fZ7GLkyTed4+Yuyp94zfVsgBv2+fULKJQEPq8CJk9AeU9q5fb112ifF+9spAwEwJ
	n6Qcld4PxraZCvOu1c3Z4NJaLS99MkY/7JCe283SZQqqwBqXoRcunozAk86rnMfUskpH
	z61g==
X-Gm-Message-State: AEkoouu+Z00hBHeFhAxaYhduTHiXDXKcZ2UWmAz+Z0VLKiSlZXZOfPflD9rFsst2JGThtw==
X-Received: by 10.98.34.66 with SMTP id i63mr172144435pfi.130.1470753220133;
	Tue, 09 Aug 2016 07:33:40 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:b8c:29dc:cb12:3198:ca66?
	([2601:646:8882:b8c:29dc:cb12:3198:ca66])
	by smtp.gmail.com with ESMTPSA id p9sm56639322pfj.3.2016.08.09.07.33.38
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 09 Aug 2016 07:33:39 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Pgp-Agent: GPGMail
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <20160809093647.GP4674@axis.com>
Date: Tue, 9 Aug 2016 07:34:14 -0700
Message-Id: <917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
To: Olof Johansson <olof.johansson@axis.com>
X-Mailer: Apple Mail (2.3124)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Tue, 09 Aug 2016 14:33:39 -0000
X-Groupsio-MsgNum: 7831
Content-Type: multipart/signed;
	boundary="Apple-Mail=_8599C200-531C-4680-8DFC-4C3B78599C45";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_8599C200-531C-4680-8DFC-4C3B78599C45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Aug 9, 2016, at 2:36 AM, Olof Johansson <olof.johansson@axis.com> wrote:
> 
> On 16-08-08 10:22 -0700, Khem Raj wrote:
>> you are confusing how a tool is specifying its functions with
>> process that could emulate a different behavior. OE does not
>> have any control over the internal processes of its users and
>> it should not have.
> 
> No, I don't think I'm confusing anything. Are you confusing OE
> and bitbake? We maintain and develop an in-house Poky based
> distribution, and unlike OE, we know a lot about our
> users/developers.

its a typo.
Thats fine. You can maintain this change locally for your use case.

> 
>>> Tags are only a problem in git if people insist on
>>> modifying/deleting them.
>> 
>> Fact is, its allowed rewrite tags in git, how people use it or not
>> is irrelevant here.
> 
> Nope, Git is a protocol; git the tool can't do nothing about a

Too literal, I guess a reader is getting what I was referring to

> server refusing to (re)move a tag. Your view of what a git tags
> is yours. Tags are meant to be static, otherwise they wouldn't
> have been synced to all clones in such a silly namespace.
> 
> While I agreed with Tobias' patch ("if you use tags in your
> builds, and use BB_NO_NETWORK, you are ok with falling back to
> what you have locally"), RP had a point about this making
> BB_NO_NETWORK have non-obvious side-effects, and also making it
> harder to catch cases where tags aren't wanted (like in community
> maintained layers).
> 
> But *we* still want to use human readable tags as the only
> version string internally (for our layers), where we know we are
> in control. So, introducing a variable that lets us opt-in to
> this behavior sounds like something that could be accepted?

If you were to think of a tool to generate the srcrevs from tags, that IMO
can be better solution here. Like Paul suggested.

--Apple-Mail=_8599C200-531C-4680-8DFC-4C3B78599C45
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlep6eoACgkQuwUzVZGdMxQK9gCfVP4Rp3vVpRj/F8FhDPmOZpFg
8xcAn1E0hW3PD9ko11Dq9vM6PVlrKGfm
=NAGC
-----END PGP SIGNATURE-----

--Apple-Mail=_8599C200-531C-4680-8DFC-4C3B78599C45--
