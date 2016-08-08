Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 74C1977158
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 17:21:35 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id y134so25361327pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Aug 2016 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:from:in-reply-to:date:cc:message-id:references
	:to; bh=7838Iw76e9gWkd7XqHkOIRupjyYINRX+SMXPNY9QQTg=;
	b=ScalZ5rLJb7zp4ulZ9KfknGnDczdL/afkdxEIJZRJxrFfX6B8ABzVVwAuSldI4zGho
	RKWv81VGG8ubMhZOL56hatUOXC//x62lZcalJ+bwCHh2qSBzFFFvvJ8MA5zLKaM95NpR
	K9f2/dvtv5zZgio2PdTCgB89/MqAQkGz/RmTfrZRSVimTO9irJ/ifW4mF/yW8IC6Lp9o
	r2gRtYa1KqTPjghOwQpCudvKyj9VB//VyhtooBB5/gEOmihE9022eWURy+0l0ZlcsoYU
	W/yM/YnzT0AiQBvDB/0bTVsw4ZR/gHiMgAbbrprG5R2Jg2oM6rU9xRbeEbeS2f3H7FeR
	BgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=7838Iw76e9gWkd7XqHkOIRupjyYINRX+SMXPNY9QQTg=;
	b=IDjuyAYLuBh7NKjFExV7W4JZrCKyOl71CH786FC4sXxTvg/4jqEnDOAgP6B31pqLCp
	H3nML6TLxMlJGtlz88yziIh11wUGq2V3Z2OV03Y1P2EPAOzn8EYGQytm0KXOuDw17PGf
	36NzqZZ6dbwXRzHj5obzuoDbRB8McHxmKxhh0AWNVFw/QPfl3NOgkKOmLc9h5aTuQXMQ
	JVOfZeKa6mXHm8OlY/4nkCltX5LWZRibYlhB30b3l5Tqiy3y3nCTfU93u7k6xxsIfQbJ
	hbmQfSQGdrButYE208DJhvAVwgn+4euEoI40eXhNf6WM+YfnEp9yDpzzMkUthy2+FWl+
	NBLw==
X-Gm-Message-State: AEkoouvl7VeODiRCCAWcQdiQw8+OsaLJ/Mvgqakq2jXMzNMFDMWMTwo01El5y1SSnuoGPw==
X-Received: by 10.98.73.131 with SMTP id r3mr163795422pfi.112.1470676895900;
	Mon, 08 Aug 2016 10:21:35 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:b8c:ddaa:6f66:32b4:378?
	([2601:646:8882:b8c:ddaa:6f66:32b4:378])
	by smtp.gmail.com with ESMTPSA id
	ao6sm49835727pac.8.2016.08.08.10.21.32
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Aug 2016 10:21:34 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Pgp-Agent: GPGMail
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <20160808163926.GO4674@axis.com>
Date: Mon, 8 Aug 2016 10:22:03 -0700
Message-Id: <5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
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
X-List-Received-Date: Mon, 08 Aug 2016 17:21:36 -0000
X-Groupsio-MsgNum: 7821
Content-Type: multipart/signed;
	boundary="Apple-Mail=_9168702A-6DBC-4BA5-AA07-941DCC3EFBB5";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_9168702A-6DBC-4BA5-AA07-941DCC3EFBB5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Aug 8, 2016, at 9:39 AM, Olof Johansson <olof.johansson@axis.com> wrote:
> 
> On 16-08-08 08:35 -0700, Khem Raj wrote:
>> tags are floating types in git, you can not use them reliably.
> 
> This is not always true.

you are confusing how a tool is specifying its functions with process
that could emulate a different behavior. OE does not have any control
over the internal processes of its users and it should not have.

> We could choose to trust tags set
> according to our processes to not move (e.g. enforced rules that
> disallows deletion/updates of tags), and only use tags for these
> recipes, and rely on commit object ids eleswhere.
> 
> Tags are only a problem in git if people insist on
> modifying/deleting them.

Fact is, its allowed rewrite tags in git, how people use it or not
is irrelevant here.

> 
> --
> olofjn


--Apple-Mail=_9168702A-6DBC-4BA5-AA07-941DCC3EFBB5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAleov8AACgkQuwUzVZGdMxRTNgCggdWdH8FOj7ElKAuSrdirQx9I
E9IAnitJiKmw6F7w5rg3aQkiqog+PX3y
=NSoX
-----END PGP SIGNATURE-----

--Apple-Mail=_9168702A-6DBC-4BA5-AA07-941DCC3EFBB5--
