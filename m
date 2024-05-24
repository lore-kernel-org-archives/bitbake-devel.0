Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902EC25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 13:09:11 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.15348.1716556146051206356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 06:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EgRlWjyV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35502a992c9so1346692f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716556144; x=1717160944; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7lM2mb4w2T66Qb7MYRi8LPCEBOuSOlRGvkQXIFtwFYM=;
        b=EgRlWjyVDUWzRd8lj2JHBY6PMODEmZnoQhDRRk7lzPu5JFc7LVg2Lb4MIxSLVau02i
         OG1tcKajmBCsntNGmGKR7xT5PD+k5K7LW8P5krxAAKZRvynluJopIbUUCu/nYgdqEM94
         A3ZDMUk1kr5zq/LWCcvmnNMwMoIvLytCifHl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556144; x=1717160944;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lM2mb4w2T66Qb7MYRi8LPCEBOuSOlRGvkQXIFtwFYM=;
        b=PJ+Nxj17IsrCBzwa0lOknZVmT1ID01Y9pwcZzbPzvAWG4FMpzCfa6u8M+ePOnExKa8
         nX+/j447mjZ3xaZqgcJa9/+gtt7RJ4PlTkSIEqmOP/Bflj0rWBFQVbcyYE+xn92oSUPD
         7D7KGUEdfuKyO3CYf7sgPeqYEZ8xmPNuE9LIqyiAYrEJbcUg9WR7LxIr5NTSnKPH6nqi
         nHoSsOfU9FnT9ft2xUFJiEW7A7VqKgaI0l/uwV/xXBl8yRTz5FVBGVS/zq1cv0KYyGyf
         gMwxH/ISBIBGUj5nlJliOhlCfCOK6nySHlMuss1kYx/Bq35Ut4ysqBq40KOp78HRmw3S
         QTnQ==
X-Gm-Message-State: AOJu0Yy7vdQyJwbwx8sE0pVY1agX6r9s7Q9GSnV9kQ6eENgJjJmJIy9s
	duEVbwum9v2LHcpleeMxcZF99AKcNUdRhf8zZT+Yt4bxBSd0Vf7YJPO1JsqyY9fOMk/bOhSkojX
	3
X-Google-Smtp-Source: AGHT+IF7qOh3ottkFjieknbJSwgxU7SgTu7EQFZXbHXGorswbpnGQPW/JZzt0k/WmQtMPMclroEVGA==
X-Received: by 2002:a5d:5966:0:b0:353:778c:d28 with SMTP id ffacd0b85a97d-3552fe18046mr1753564f8f.64.1716556144114;
        Fri, 24 May 2024 06:09:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9ca4:3686:8521:57da? ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dd8esm1576377f8f.10.2024.05.24.06.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:09:03 -0700 (PDT)
Message-ID: <4d653b3eb9091d15c2989ec786f57df8a38e308f.camel@linuxfoundation.org>
Subject: Further hashserve performance numbers for various runqueue changes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, Michael Halstead
	 <mhalstead@linuxfoundation.org>, Joshua Watt <JPEWhacker@gmail.com>
Date: Fri, 24 May 2024 14:09:00 +0100
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 13:09:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16250

I've various patches floating around to enable the get_unihashes()
instead of get_unihash inside the two key loops of runqueue.py and also
to skip further checks if the base dependencies fail. I also have
patches which add benchmarking code, I think I'll merge that with
30s/60s time windows, the code below is with 1s checks.

The patches have had various challenges and probably aren't ready for
production but I had some numbers on the performance impacts.

The data below is for "bitbake world" against our public hashserve with
either BB_HASHSERVE_MAX_PARALLEL =3D "20" or "1" and with or without the
"skip" code.

The parallelism patches should be safer so I'll try and get them in
first, those may be good enough for scarthgap if we set MAX_PARALLEL
too.

I think the initial loop issues are mitigated but the rehash loop can
still be very very slow in test builds.

Cheers,

Richard


World build with parallel=3D20:

NOTE: Initial setup loop progress: 19659 of 20934 in 4.1138129234313965####=
#######################                                                    =
                                         | ETA:  0:00:02
NOTE: Initial setup loop progress: 17312 of 20934 in 5.2344651222229
NOTE: Initial setup loop progress: 17145 of 20934 in 6.307123899459839
NOTE: Initial setup loop progress: 16434 of 20934 in 7.317627429962158
NOTE: Initial setup loop progress: 13815 of 20934 in 15.652806758880615
NOTE: Initial setup loop progress: 13371 of 20934 in 16.671403646469116
NOTE: Initial setup loop progress: 13230 of 20934 in 17.681148052215576
NOTE: Initial setup loop progress: 13042 of 20934 in 18.811992645263672
NOTE: Initial setup loop progress: 12839 of 20934 in 19.91770839691162
NOTE: Initial setup loop progress: 12780 of 20934 in 21.44238018989563
NOTE: Initial setup loop progress: 11925 of 20934 in 23.013920068740845
NOTE: Initial setup loop progress: 11366 of 20934 in 25.644384384155273
NOTE: Initial setup loop progress: 10953 of 20934 in 26.855393648147583
NOTE: Initial setup loop progress: 10650 of 20934 in 28.030822277069092
NOTE: Initial setup loop progress: 10437 of 20934 in 29.077589750289917
NOTE: Initial setup loop progress: 9879 of 20934 in 32.78623652458191
NOTE: Initial setup loop progress: 9511 of 20934 in 34.75427579879761
NOTE: Initial setup loop progress: 9084 of 20934 in 36.521671772003174
NOTE: Initial setup loop progress: 8449 of 20934 in 38.2259840965271
NOTE: Initial setup loop progress: 7817 of 20934 in 39.5151252746582
NOTE: Initial setup loop progress: 7148 of 20934 in 42.065367460250854
NOTE: Initial setup loop progress: 6772 of 20934 in 43.161072969436646
NOTE: Initial setup loop progress: 6251 of 20934 in 46.476539611816406
NOTE: Initial setup loop progress: 5991 of 20934 in 48.0325403213501
NOTE: Initial setup loop progress: 5396 of 20934 in 51.441262006759644
NOTE: Initial setup loop progress: 5157 of 20934 in 52.652904748916626
NOTE: Initial setup loop progress: 4820 of 20934 in 54.40692615509033
NOTE: Initial setup loop progress: 4534 of 20934 in 55.852611780166626
NOTE: Initial setup loop progress: 4305 of 20934 in 57.171926975250244
NOTE: Initial setup loop progress: 4155 of 20934 in 58.29427623748779
NOTE: Initial setup loop progress: 3978 of 20934 in 59.314293384552
NOTE: Initial setup loop progress: 3782 of 20934 in 60.332558393478394
NOTE: Initial setup loop progress: 3450 of 20934 in 61.69766283035278
NOTE: Initial setup loop progress: 3224 of 20934 in 62.79667639732361
NOTE: Initial setup loop progress: 2791 of 20934 in 63.80335450172424
NOTE: Initial setup loop progress: 2349 of 20934 in 65.89782404899597
NOTE: Initial setup loop progress: 1938 of 20934 in 67.3385021686554
NOTE: Initial setup loop progress: 1684 of 20934 in 68.69064450263977
NOTE: Initial setup loop progress: 1429 of 20934 in 69.72822642326355
NOTE: Initial setup loop progress: 1195 of 20934 in 71.14511466026306
NOTE: Initial setup loop progress: 982 of 20934 in 72.49229049682617
NOTE: Initial setup loop progress: 623 of 20934 in 73.9055724143982
NOTE: Initial setup loop progress: 373 of 20934 in 75.55642104148865
NOTE: Initial setup loop progress: 159 of 20934 in 76.864262342453
NOTE: Initial setup loop progress: 50 of 20934 in 78.01565289497375
NOTE: Initial setup loop took: 78.92819929122925

World build with parallel=3D1

NOTE: Initial setup loop progress: 19659 of 20934 in
44.61497211456299############################                        =20
| ETA:  0:00:02
NOTE: Initial setup loop progress: 17352 of 20934 in 52.7748703956604
NOTE: Initial setup loop progress: 17276 of 20934 in 54.11460471153259
NOTE: Initial setup loop progress: 17197 of 20934 in 55.663928508758545
NOTE: Initial setup loop progress: 17145 of 20934 in 56.992905378341675
NOTE: Initial setup loop progress: 17001 of 20934 in 58.548869371414185
NOTE: Initial setup loop progress: 16474 of 20934 in 59.77568531036377
NOTE: Initial setup loop progress: 16394 of 20934 in 60.886287450790405
NOTE: Initial setup loop progress: 13815 of 20934 in 215.0232880115509
NOTE: Initial setup loop progress: 13630 of 20934 in 216.04719042778015
NOTE: Initial setup loop progress: 13444 of 20934 in 217.36736249923706
NOTE: Initial setup loop progress: 13299 of 20934 in 225.0512375831604
NOTE: Initial setup loop progress: 13178 of 20934 in 227.6976819038391
NOTE: Initial setup loop progress: 13134 of 20934 in 229.27266097068787
NOTE: Initial setup loop progress: 13042 of 20934 in 230.32352781295776
NOTE: Initial setup loop progress: 12914 of 20934 in 231.37630605697632
NOTE: Initial setup loop progress: 12839 of 20934 in 232.81588578224182
NOTE: Initial setup loop progress: 12788 of 20934 in 233.96716022491455
NOTE: Initial setup loop progress: 12371 of 20934 in 243.33956265449524
NOTE: Initial setup loop progress: 11925 of 20934 in 253.05826711654663
NOTE: Initial setup loop progress: 11724 of 20934 in 262.3110167980194
NOTE: Initial setup loop progress: 11366 of 20934 in 298.3888895511627
NOTE: Initial setup loop progress: 11238 of 20934 in 305.2889611721039
NOTE: Initial setup loop progress: 11044 of 20934 in 307.5863687992096
NOTE: Initial setup loop progress: 10871 of 20934 in 309.8870234489441
NOTE: Initial setup loop progress: 10650 of 20934 in 325.858434677124
NOTE: Initial setup loop progress: 10437 of 20934 in 343.2699041366577
NOTE: Initial setup loop progress: 9879 of 20934 in 410.875333070755
NOTE: Initial setup loop progress: 9763 of 20934 in 417.25283122062683
NOTE: Initial setup loop progress: 9511 of 20934 in 444.3516962528229
NOTE: Initial setup loop progress: 9351 of 20934 in 448.10569167137146
[gave up]

World build with parallel=3D1 but skip if not seen code:

NOTE: Initial setup loop progress: 19659 of 20934 in 42.415175437927246 (12=
75 1024)###############                                                    =
                                         | ETA:  0:00:02
WARNING: Initial setup loop progress: 19659 of 20934 in 42.415175437927246 =
(1275 1024 1158)
NOTE: Initial setup loop progress: 16700 of 20934 in 43.41557860374451 (272=
7 2476)
WARNING: Initial setup loop progress: 16700 of 20934 in 43.41557860374451 (=
2727 2476 1158)
NOTE: Initial setup loop progress: 9879 of 20934 in 44.48278522491455 (2727=
 2476)
WARNING: Initial setup loop progress: 9879 of 20934 in 44.48278522491455 (2=
727 2476 1158)
NOTE: Initial setup loop progress: 2896 of 20934 in 45.50811767578125 (2727=
 2476)
WARNING: Initial setup loop progress: 2896 of 20934 in 45.50811767578125 (2=
727 2476 1158)
NOTE: Initial setup loop took: 46.00780510902405

World build with parallel=3D20 and skip if not seen code:

NOTE: Initial setup loop progress: 19659 of 20934 in 6.287478446960449 (127=
5 1024 1158)###########                                                    =
                                         | ETA:  0:00:02
NOTE: Initial setup loop progress: 13815 of 20934 in 7.317503929138184 (272=
7 2476 1158)
NOTE: Initial setup loop progress: 9351 of 20934 in 8.32596230506897 (2727 =
2476 1158)
NOTE: Initial setup loop progress: 2153 of 20934 in 9.349291324615479 (2727=
 2476 1158)
NOTE: Initial setup loop took: 9.7362699508667




