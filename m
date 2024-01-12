Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91070C47258
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 15:40:54 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.10229.1705074045639010414
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 07:40:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fa9satmh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e613b6afbso18349585e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705074044; x=1705678844; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RryMN4jmZBA2/oliKkhjQ6R4spuXNhsL+w8ejFB42po=;
        b=fa9satmhvRqWDahm25aMpoK4pXqMxB6nC8ZIh7yfI0uv6zKwN5A5q/6Aw6JpEOeT8b
         5A1UJlUVS0zC2WAAcBapQpikffJuDPICybSWy72QzQP5POFmElTibVeFE1/1exiCFEhR
         6x3N854qXva4I/MfvTRVUH6oKvQhfXyTbjT/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074044; x=1705678844;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RryMN4jmZBA2/oliKkhjQ6R4spuXNhsL+w8ejFB42po=;
        b=BEL3pCvl5pgFOtA5q2qYyX4Jzp54akUq59Smtso8aU2GZjFUq13xAR+DcKSzzQJ7uN
         f4d0X5EV3wTNS0rT9+LhUqf/GB8TNs0xKN+ArVgkbpwMWLMRD9iF+AQGkij4wQr/Pbxr
         pN+Bpvz/ytE6QLfDaROmS7EPhN8vnmHiMod+tB0Ys8839p+48N4nuaxAUCCIXkP6HK0w
         Pc88VbBc9pLBBl5xflfqyq0rDusYyKrZE2Xcyie6+ULcOwSriGx/q95PjKzxXuPY1UrS
         CK0RBidXXHlvWk+dTZoXlLTWs74Buqr/SN3xgwJ0dns3bixANulyIdP6Wn4zDGWHmfzG
         WsEg==
X-Gm-Message-State: AOJu0YzOjx9QY6MaqPwoQ5BZre5dCYH1UrsRy+g5eXxo6KHq323auS5d
	rdOAhNIJxheBaTlJ8rGt2NHqZNuB52xOYQcK2hknajH/DXQ=
X-Google-Smtp-Source: AGHT+IGKJL9ymwZvBBzM9bw/B2nUM4WHWKeha1MNLmUXtOhgQByuGNyBUc8xz45+iHyUDVZZK+R7Jg==
X-Received: by 2002:a05:600c:17d3:b0:40d:5c7e:6f69 with SMTP id y19-20020a05600c17d300b0040d5c7e6f69mr866163wmo.147.1705074043851;
        Fri, 12 Jan 2024 07:40:43 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:54d1:179:7c44:2de? ([2001:8b0:aba:5f3c:54d1:179:7c44:2de])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0040e4914f28dsm9989945wmq.18.2024.01.12.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:40:43 -0800 (PST)
Message-ID: <81d4da494bd7b892c906e82caee977ef986b98c3.camel@linuxfoundation.org>
Subject: My notes on importing commandline builds into toaster
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	"toaster@lists.yoctoproject.org"
	 <toaster@lists.yoctoproject.org>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Martin Jansa
 <martin.jansa@gmail.com>, Mohammed Raza <mohammed.raza@savoirfairelinux.com>
Date: Fri, 12 Jan 2024 15:40:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 15:40:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15788

Since we now have toaster back and operational and able to import
commandline builds, and we have a usecase where this might be useful, I
thought I'd try it and see what works/doesn't work.

Alex Kanavin mentioned this build has issues:

https://autobuilder.yoctoproject.org/typhoon/#/builders/88/builds/3515

I went in and saved the eventlog:

https://autobuilder.yocto.io/pub/failed-builds-data/20240112030913.json.zst

then I tried to import this into a locally running instance of toaster.
I had to compress/decompress the file as it was large.

Toaster failed locally to import the build with no error given on the
UI. Form the commandline it became clear it was trying to do "mkdir
/home/pokybuild" which clearly isn't my local username. I created the
directory just to move past this.

The build then imported from the commandline. The issues I noticed were
then:

* the build duration was incorrect as it timed the event replay rather
than the original build
* toaster.bbclass wasn't included so the layerconfig is missing
* buildstats info was missing as those weren't present
* log links don't work as I didn't download the logs locally
* the UI doesn't use any of the event timestamp data, just that from
buildstats.
* the cooker log is the replayed cooker log rather than the original
one
* trying to view logs results in tracebacks

Unfortunately toaster doesn't display start/end times of the task and
doesn't let you view the events themselves so it wasn't so useful for
what I wanted to look into. You can get the task ordering if you add
that field to the display (it isn't there by default) which did help a
bit.

I did save the buildstats so I could try a second run with more data:

https://autobuilder.yocto.io/pub/failed-builds-data/stats.tgz

Since I'm documenting this, I may as well save the logs too:

tar -czf stats2.tgz buildstats log work/*/*/*/temp/

https://autobuilder.yocto.io/pub/failed-builds-data/stats2.tgz

Sadly even with that data restored to the correct place, it didn't load
into the system correctly for some reason. I realised this may be
because I didn't have the json eventlog in situ so retried again with
that in the original build path but that didn't improve anything.

I also realised toaster does read the packageinfo task data which I
didn't have present so package information wasn't added.

All in all, an interesting learning experience and we've some work to
to do improve the experience here.

Cheers,

Richard





