Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3E4A67721F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 15:54:10 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id hh10so1150774pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Aug 2016 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:from:in-reply-to:date:cc:message-id:references
	:to; bh=bet5Etl8dSrmzWV5Hc3J9fnpmCDi0tHSFrFtulweQEE=;
	b=DwdLwBpnFVW+9nfzIOOwV0WHMqf3RbtkOchI2vutA2tfuI7ZNEtQQNIPV/kbmIWfdx
	yjVEDPOu+ZlVdDhOV5BcSsqtEvhzf3K/oKcc+DFzB0KljlVEU/fSHc5QprEpjRf7kWU4
	IsVWKwAkerpuGNADkBm5AA14BBPfxEJRhoRFwgxpEQuHgbbMaTaGdW9A+olryXeaEE9p
	z+ddvk2RttyE6ZDXNfh3JeyCA2H2GK90Aw/V1VO5/eB+D+sWW8i6QHD6ZY2rXEcfmA3A
	VjRrWKNwZiYEpb9PBLsRyiG0GWP3+02dshQy/nZxF0djqdCpBN8ugU/P4JV3hmObInLk
	nxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=bet5Etl8dSrmzWV5Hc3J9fnpmCDi0tHSFrFtulweQEE=;
	b=Gvg/Wr9twwZqdb5ONSeZtWhzvP7avCGifrXjwedqWE6EhEvoA0w23wpdFjwCj0Vn01
	nCelxofkLSXBLpPRBdVq3qtBZIdKzWpGObnFBwXNPThLz9goayZGFSlSN8M+mzkyDPRY
	jyZTEIhvfxULb6mzsIuaf28E01hWYIsg2pf7fMcECAy5Gyx8SeALOrU2ZpgzCSPHQFXf
	MobAdA6gz9vkvnFeKUOh3WA1awPKI+UmiRBn3w5mMY1JPNZG/KYquNZZ16SW5BuwpHri
	+1q5hI9cI//QrfoWXw0UXdiOTirHAaqF5rh0mAXATpPoQZ5cOiYs6Q5gIJwugvF3aOWr
	DDCQ==
X-Gm-Message-State: AEkoousP3R+CcRaUTsEn9OVXaG5IUkQS9n3qiRkbanzOyNUTsd/XgF18guTg2EEEymywYA==
X-Received: by 10.66.82.42 with SMTP id f10mr174151638pay.17.1470758051439;
	Tue, 09 Aug 2016 08:54:11 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:b8c:29dc:cb12:3198:ca66?
	([2601:646:8882:b8c:29dc:cb12:3198:ca66])
	by smtp.gmail.com with ESMTPSA id
	o80sm57046409pfa.67.2016.08.09.08.54.10
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 09 Aug 2016 08:54:10 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Pgp-Agent: GPGMail
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <20160809150902.GR4674@axis.com>
Date: Tue, 9 Aug 2016 08:54:46 -0700
Message-Id: <601FD807-0341-4764-AE68-0E3DA0BB0E11@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
	<917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
	<20160809150902.GR4674@axis.com>
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
X-List-Received-Date: Tue, 09 Aug 2016 15:54:11 -0000
X-Groupsio-MsgNum: 7833
Content-Type: multipart/signed;
	boundary="Apple-Mail=_62CB5B9B-3D4B-4604-B569-0095F0864419";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_62CB5B9B-3D4B-4604-B569-0095F0864419
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Olof

> On Aug 9, 2016, at 8:09 AM, Olof Johansson <olof.johansson@axis.com> wrote:
> 
> On 16-08-09 07:34 -0700, Khem Raj wrote:
>> Too literal, I guess a reader is getting what I was referring to
> 
> No, a reader did not understood what you are talking about.
> Quite frankly, you're not being constructive here Khem. Assuming
> that I'm confusing things because we have differences in
> opinions, and that it doesn't matter that I don't understand what
> you are saying as long as you think that other people do is not
> very helpful. What's the point in discussing anything with you?

I am sorry if its coming across this way.I for one was trying to convey
that there are reasons to not have such a patch e.g. predictable
builds and general support problems with BB_NO_NETWORK.

We have been through this very same problem and decided to use srcrev
collection approach which is similar to buildhistory collection
approach. It was a bit of getting used to, but in the end it was
a very good way.

> 
>> If you were to think of a tool to generate the srcrevs from
>> tags, that IMO can be better solution here. Like Paul
>> suggested.
> 
> Yes, Paul's suggestion was very constructive (thanks!), and
> that's something we might do. But it still forces us to deal with
> sha1 revision ids. Would require effort on our part to hide this
> from our users and automate it somehow. Some issues that we would
> like to handle:
> 
> - changing PV won't have any effect on what source is fetched/used

I believe it should not.

> - changing SRCREV to another revision won't affect PV

If you do not utilize SRCPV in PV variable. SRCREV should not reflect
in the PV

> 
> --
> olofjn


--Apple-Mail=_62CB5B9B-3D4B-4604-B569-0095F0864419
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlep/MoACgkQuwUzVZGdMxSiSgCfdOpGsqUo+Yyb9JMKhcWDZQn/
NMcAn1ZqW7AGA4ZHAACtwuj/hyeZUkBG
=rtnw
-----END PGP SIGNATURE-----

--Apple-Mail=_62CB5B9B-3D4B-4604-B569-0095F0864419--
