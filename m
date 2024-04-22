Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A7C4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 14:48:13 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.20487.1713797283228279410
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Apr 2024 07:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e97DbZCN;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so2834456e87.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Apr 2024 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713797281; x=1714402081; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtZb/cdLFVBhkQlCWnPHBmJtrViJm3HsZlQtAcMoyQs=;
        b=e97DbZCNKtzx31fpqO9DcFnhH4Q4Wm0EYtYQHcbCNEzCw4EDrJvgIjrhMDMFjJzE4M
         7uaMSOr3cd/2wphL8h14F/S4RGkhL3OyMw4MKsP2Q/aunFHB6FwASxjtUavIlL2HwqYg
         MZDdFjSFTD8OghLWD48pcobyF3tKdY8UEeqIobzSFryZ9Q8Wtw4tkHGjlte71TYO54gq
         56b2iF8fPDZstD24YudbGj6sr2hOTVD9PJLxDO1opeobNYLXvLqRkWkJYKDc9QAcVdfZ
         SIuJF0FEzirkNDtdbREcQJqKP1OhHMaSCxkZEHOvtbZLW6Q34khDvKdy/npxvyPwz7BQ
         cblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713797281; x=1714402081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtZb/cdLFVBhkQlCWnPHBmJtrViJm3HsZlQtAcMoyQs=;
        b=mm6I4Ft/VlnGpRanLU80gpOiJhO5Ve/m4o2Ox/oOGthmqFVrM2Mg4CKyvriIyB126n
         6C3OHteOCaEit7y1aa6rHqBqqyTdZnuAS3A8A5Bb0utpTT7n6zEM3Er8zQRGlM3CLhQV
         Y7w1ub8pvltpDgcp1eBH/ixw2Qtoxc9QvY49szAN4egHP3nbpXo6bYvSwv5Ha2VJm1QL
         mRYHHEkB3nurKINfHeDo7yJ3fMekavCpI5fhbmYjx58R5W18zTZVplAUI0rgbjkR322+
         BLjU0DhDMeAslQW2TM1wlQ134wuq5w6ld7dqZ95PDYYY2CL+k2BL4OLIZT+zgqRoH+xf
         gywA==
X-Forwarded-Encrypted: i=1; AJvYcCWziFhlv6aitEHeoKVQyxkMTLDGp3rNeLU9BNsRNr0BwoQGYd/X6dyJn8RhM3PFajxpZjTs2br/7mDD/ZFLMzkhNQHd4XkS1O3tuCwQYo8Gc9Qh+Bs=
X-Gm-Message-State: AOJu0YzzVcAdW019/qtS5fbu+WkzdukRVUxhBu9Px//89N+TZRVwVrVq
	9H5421DImiotaybiWOCEH1X/tl1WpNAFoVvsdseJO9P6XksZ/nB1Oio8E730zPKX7eoRY4hjt6z
	uTZLKg3b4bOBZ4lvrlJAi7NzrNCg=
X-Google-Smtp-Source: AGHT+IGG9PqS/f+gmUmoKy+6lYnj6SrAm8m93PxEdiRHUo33ts+JbQ0JXh5Nb5tmxbcmJ5PUR3U7AQ6ekQkDOsDZIMw=
X-Received: by 2002:a05:6512:4026:b0:51a:ebf8:c89a with SMTP id
 br38-20020a056512402600b0051aebf8c89amr5693378lfb.57.1713797281019; Mon, 22
 Apr 2024 07:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com> <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
 <10108676.tdPhlSkOF2@arbeit>
In-Reply-To: <10108676.tdPhlSkOF2@arbeit>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 22 Apr 2024 08:47:48 -0600
Message-ID: <CAJdd5GahxnL8ab7rh5bggOhh7CnT6ry8WzfT-aZEpvmMTmDE4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-selftest losing sqlite3 database contents!
To: =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>, bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, jsmoeller@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Apr 2024 14:48:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16121

On Mon, Apr 22, 2024 at 4:00=E2=80=AFAM Jan-Simon M=C3=B6ller <dl9pf@gmx.de=
> wrote:
>
> Am Samstag, 20. April 2024, 22:35:33 CEST schrieb Joshua Watt via lists.o=
penembedded.org:
>
> > I'm not exactly sure what the purpose of the read-only prserv is in
> > the first place; based on these requirements, it sort of sounds like
> > there isn't anyway to make a read-only server that has actual data in
> > it :)
>
> Well what about this use-case:
> An CI loop would populate using a rw PR-server , those artifacts (sources=
, sstate, hashserv(!), deploy dir)
> are then pushed to a download server. We do not want to expose that r/w P=
R-serv publically.
> Now for a binary feed-like setup, we'd need a matching PR and Hashserv fo=
r the downstream. No ?
> Thus extra r/o instances sharing the same sqlite in the back.
> Isn't this then required for a downstream user to create their own 'match=
ing' binaries for the feed ?
>
> Correct me, but e.g. this is what we assume is the way to expose the data=
:
>
> # rw prserv on port 8181
> bitbake-prserv --start --file /home/yocto/pr_hash_serv-volume/prserv.db -=
-loglevel=3DDEBUG --log /home/yocto/pr_hash_serv-volume/prserv-rw.log --por=
t 8181
> # ro prserv on port 8282
> bitbake-prserv --start -r --file /home/yocto/pr_hash_serv-volume/prserv.d=
b --loglevel=3DDEBUG --log /home/yocto/pr_hash_serv-volume/prserv-ro.log --=
port 8282
>
> # rw hashserv on port 8383
> bitbake-hashserv --bind :8383 --log DEBUG --database /home/yocto/pr_hash_=
serv-volume/hashserv.db > /home/yocto/pr_hash_serv-volume/hashserv-rw.log 2=
>&1 &
> # ro hashserv on port 8484
> bitbake-hashserv -r --bind :8484 --log DEBUG --database /home/yocto/pr_ha=
sh_serv-volume/hashserv.db > /home/yocto/pr_hash_serv-volume/hashserv-ro.lo=
g 2>&1 &
>
>
> @Richard/Josh:
> Let me add (yes, grumble a bit ;) ) : for me as *end user* of this, this =
is all the same and would be best kept in one single server that I can scal=
e.
> Having it split into two just complicates things ... and now for scarthga=
p, we need another instance of the hashserv due to the API change.
> Please consider this from a user perspective working on multiple branches=
 and not just one master branch!
> The data might not be 'the same' or not 'connected', but they are still l=
inked in a way and moreover we are exposing this to users
> to use and usage gets mandatory if we think of speeding up builds and bin=
ary feeds. Don't get me wrong, this is good stuff, but we make it hard for =
general use.
> Wrt scaling: - essentially we're setting us up with scaling problems wrt =
prserv down the road when it gets needed for binary feed.
> Heck, we're just solving this for hashserv, so why not do this likewise r=
ight away - at best put both in one server?

Can you clarify what you mean by "both in one server"? There are a lot
of different levels of varying complexity that could be done for that.
For example, you could:
1) Run both servers as separate processes in e.g. a shared container
2) Run both servers in a shared script
3) Combine the API into a single server API

These are generally more complex with more caveats as you go; #1 is
the "easiest", #2 isn't possible until the PR server is completely
asynchronous like the hashserver (otherwise it won't scale at all),
and #3 is basically a completely new (breaking) API.

My preference is #1 or #2, but #2 makes no sense until the PR server
has all of the features of the hash server; this patch series adds
websockets which is a good step, but it would also need the database
backend re-written to be nonblocking like the hash server, otherwise
it's just asking for scaling problems if you run them in the same
process :)

Also keep in mind that one of the goals of the websockets server is to
reduce the need for the "read-only" server, since you can have your CI
authenticate with the hash server and get rw access, but anonymous
users can be given read-only access.

In short, there is space to make it a little easier to stand up the
servers in some common ways, but I'm hesitant to force everyone to run
the servers a specific way as I don't think there is a "one size fits
all".

>
> @Michael: the 'empty file' issue rings a bell and I've seen this back whe=
n we tried this for the first time.
> Export did not work either. But I have a hard time remembering the detail=
s. Might even depend on sqlite versions back then.
> I found this in my local git:
> sed -i -e "s#EXCLUSIVE#IMMEDIATE#g" /home/yocto/poky/bitbake/lib/prserv/d=
b.py
> It probably helped some but might cause other issues. Let's see what the =
experts say.
>
>
> > Ostensibly, you should be able to write a test fixture that does
> > whatever a real-life PR server installation would do to populate a
> > database and then make it read-only. You would then do this process on
> > the test database before each test where you needed to test the read
> > only functionality. You have to do it for each test because as you
> > noticed, you should not ever have "carry-over" in state from one test
> > to another. Having carry-over between tests is not a good idea for a
> > lot of reasons, which is why the hash server tests are setup the way
> > that they are with an empty database for each test.
>
> I second Josh here.
>
>
> Best,
> JS
>
>
>
>

