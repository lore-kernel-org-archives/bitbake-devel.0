Received: from mail-ve0-f177.google.com ([209.85.128.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1U9Yws-00013q-NQ
	for bitbake-devel@lists.openembedded.org;
	Sun, 24 Feb 2013 11:36:51 +0100
Received: by mail-ve0-f177.google.com with SMTP id m1so1590938ves.36
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Feb 2013 02:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type:content-transfer-encoding;
	bh=NHkdwuZ5uR7hNVf4GEkNE1zTzCn/3AF/S1pj/088av8=;
	b=TzYWh6q7wEtwS8rkKMVR/cslP6xLVPaarqgQ+0ZuE9HW3U6V4E/K7KusRohRDsKCdb
	tFJZUugr1tBBY/5+mpO1sNB04pYj30urXPxSseFJkvI6DWCkXetfaubVFaVPrRYlMphz
	rDpzLO/of52N0+W4Xm8DesY80ZiZu5mS9o6crjOKu5xwgVwF4NskHndqo4n0qKnmBgHE
	DtW5f2FT6pVXbP5hcwF3CZyazhCjuMsa7Fk9NlnxPTXIzj5GkhL0fDNRbVPFqv7Pl6gZ
	d3XTO/unUQliICIC87+6nCDB6SeQLnqSexfBWi26sX6wgrJzZWQOZfxuLTzQL9bNcgCx
	pcjg==
MIME-Version: 1.0
X-Received: by 10.220.219.73 with SMTP id ht9mr8257189vcb.47.1361701234237;
	Sun, 24 Feb 2013 02:20:34 -0800 (PST)
Received: by 10.52.185.168 with HTTP; Sun, 24 Feb 2013 02:20:34 -0800 (PST)
In-Reply-To: <5129636A.1070706@windriver.com>
References: <CALbNGRSGHYF0-9AgF7KmK8W_BBBOriVmx7FYupxySHUgdqKeYg@mail.gmail.com>
	<5129636A.1070706@windriver.com>
Date: Sun, 24 Feb 2013 11:20:34 +0100
Message-ID: <CALbNGRRqTbjDMRX1bLaQn-J+809cWbGaA+Wvsk0qR7Ow0jdhSQ@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: parse does not cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 24 Feb 2013 10:36:52 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2013 at 1:48 AM, Jason Wessel
<jason.wessel@windriver.com> wrote:
> On 02/23/2013 03:44 PM, Andreas M=C3=BCller wrote:
>> Hi,
>>
>> with the latest HEAD bitbake performs a full parse for every run. I
>> could not find a hint so far - so is it a bug or did I miss something?
>
> It depends on what OE you are using.  If you don't have the changes for t=
he BB_ORIGENV introduced by commit 0a99563a4ea270594fd9a61da46f9387fb79dc66=
 you will find that things definitely always parse every single time.
>
> You can always try reverting that single commit to see if the behavior ch=
anges.  There are also other changes like that with in the bitbake history =
where it does not always work with older versions of OE.
>
> Cheers,
> Jason.
You are right - reverting 0a99563a4ea270594fd9a61da46f9387fb79dc66
helps. Seems my OE does not match bitbake HEAD.

Thanks

Andreas


