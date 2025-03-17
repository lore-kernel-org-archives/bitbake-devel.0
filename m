Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A33C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 19:39:35 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.248.1742240371764951698
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Mar 2025 12:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=tt80mHQ9;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.170, mailfrom: steve@sakoman.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f679788fd1so36076717b3.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Mar 2025 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1742240371; x=1742845171; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV1ZtUWmbIEXiSEoMOWRZqk7X+B7yY+ee6gFgVqQWlI=;
        b=tt80mHQ9HbxUOQHlfdECvfXrlPALDmoaFD+X6J0cDwjrcVz3uAEsJO5dnJ/gsspKDe
         /F4OFsyLL7Kv8wLqRqi6ugJBu4pQmdppsU5yHZPGxL6aH7djk2DvamNH0t0CP0emKwhL
         zW/HNpxyaMUq6/p2tRge/r6gBOEUv66z8GwjQczxiRxLbW06BdeqlGcDhcmy1CkdXzws
         wPp0U4O8UY4Xcg9A9DspDd/BUWpSnmVrEApohojqiZJcxvN17oV1aKX8HRj5ZK/33OKX
         e4MxgJgqiSTdL9kCalKYxNPyWYgYCuY0ccLYhYgYl4WV+AXKLAUDXVr3h9Awp/T/XMBV
         jMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742240371; x=1742845171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV1ZtUWmbIEXiSEoMOWRZqk7X+B7yY+ee6gFgVqQWlI=;
        b=RygWGfydQwv12VbBmQdljg9JBazm5MjjDh9YupVROczzD+2p3jBLGV3gW0/yQj1X6t
         kp7Ros/j0KF3RYmlqhSablQajjmLjzr9OvEK2VJvQ67xH9aelTil3t4NrFqridsIejW0
         mkvX2AJ9XNsl5uHf1oy0HqxDWt+fNs91Rf9n0SxavSl87sRwLm/iWec1FtO3RSUUY3O8
         505koGHcl3CoTwsTPks20c2yhKIrxgZnNW0IeNrlVXOaWNpM+bM8scKDjaW+CDWIcyTm
         PNDwHwGpiRXeBuQ3uRIEkEpBveR8pfbTPe626k0KSiFnjSEV4rUsR4KVGhbZU36j+smj
         lpDw==
X-Gm-Message-State: AOJu0YwZNtVa9za8XCGdRJ74hi2DaTsC0LfMGhSM1kXPbQ+NJ4LpsVS5
	wtxj2U7Vh5hsQulVSG2RSjt8xkmzI+85dlhicCJFHX+ima8a9xE5pkixseP/Vce+sltqEwOlUmt
	+37ArCijjz3Vjq/NsgkbWw7imzcxgmdzwa9KmTQ==
X-Gm-Gg: ASbGncufo4P9KRBrRfU6lD644pa9VmHsbVGQLrmQnRqVOnf/dChBxPSCGsQ7z7/lcb/
	WGiDRZofr+8Dk7MinUawVBziUN80dLk4urQFNfvp1PNJG23aZtBSVj5INqcbQsAIcG508wt10xL
	w6XTuIgJksqNgSDN1wpBqGyfQ0u7v/DT9EAtmfrB4oRjZ3uSSp2kgQucgsOma41cmzE+k=
X-Google-Smtp-Source: AGHT+IGXGEtzmgnReez4INCXDJSqH7/wPxK9N+Bv6/VPWg5dcXF0f4vL3Saw3ofAmMXeElCZalaIHQF7t3XRVcO6lZg=
X-Received: by 2002:a05:690c:3613:b0:6f9:a8e7:430 with SMTP id
 00721157ae682-6ff45e687aemr157327557b3.4.1742240370849; Mon, 17 Mar 2025
 12:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250311122901.13820-1-eric.meyers@arthrex.com>
 <20250311122901.13820-2-eric.meyers@arthrex.com> <CA+cKJ+E9FAaZS+0QfUnAK5JnRXgkQpyR4H2B-mBEnUbK7KoM+A@mail.gmail.com>
In-Reply-To: <CA+cKJ+E9FAaZS+0QfUnAK5JnRXgkQpyR4H2B-mBEnUbK7KoM+A@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Mon, 17 Mar 2025 12:39:19 -0700
X-Gm-Features: AQ5f1JpMN4dwd_nsorCkiwsTZbPqUPLXqR5GjiAOxZIinve_Ra-9CiE9tm6vxG0
Message-ID: <CAOSpxdYgwqoN+jrow0qAs+kfYzJkCN+-E9ab-z9hjeURkhSXkQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][styhead][2.10][PATCH v1 1/2]
 fetch2/npm: Adding npmrc support for private registry authentication
To: eric.meyers15310@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Mar 2025 19:39:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17450

On Mon, Mar 17, 2025 at 11:56=E2=80=AFAM Eric Meyers via
lists.openembedded.org
<eric.meyers15310=3Dgmail.com@lists.openembedded.org> wrote:
>
> On Tue, Mar 11, 2025 at 7:28=E2=80=AFAM Eric Meyers <eric.meyers15310@gma=
il.com> wrote:
>>
>> From: Eric Meyers <eric.meyers15310@gmail.com>
>>
>> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
>> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
>> ---
>>  lib/bb/fetch2/npm.py | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index ac76d64cd..38f460e5b 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -91,6 +91,12 @@ class NpmEnvironment(object):
>>          self.d =3D d
>>
>>          self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", bu=
ffering=3D1)
>> +
>> +        hn =3D self._home_npmrc(d)
>> +        if hn is not None:
>> +            with open(hn, 'r') as hnf:
>> +                self.user_config.write(hnf.read())
>> +
>>          for key, value in configs:
>>              self.user_config.write("%s=3D%s\n" % (key, value))
>>
>> @@ -103,6 +109,15 @@ class NpmEnvironment(object):
>>          if self.user_config:
>>              self.user_config.close()
>>
>> +    def _home_npmrc(self, d):
>> +        """Function to return user's HOME .npmrc file (or None if it do=
esn't exist)"""
>> +        home_npmrc_file =3D os.path.join(os.environ.get("HOME"), ".npmr=
c")
>> +        if d.getVar("BB_USE_HOME_NPMRC") =3D=3D "1" and os.path.exists(=
home_npmrc_file):
>> +            bb.warn(f"BB_USE_HOME_NPMRC flag set and valid .npmrc detec=
ted - "\
>> +                    f"npm fetcher will use {home_npmrc_file}")
>> +            return home_npmrc_file
>> +        return None
>> +
>>      def run(self, cmd, args=3DNone, configs=3DNone, workdir=3DNone):
>>          """Run npm command in a controlled environment"""
>>          with tempfile.TemporaryDirectory() as tmpdir:
>
>
>
> Just poking this patch submission since I haven't heard anything since in=
itially submitting it a week ago/haven't seen anything merge yet.
>
> I know @rpurdie said it was borderline new functionality on a previous th=
read and might not be accepted into styhead (2.10) and scarthgap (2.8), but=
 just wanted to have closure if that's the case.

This does cross the line of adding new functionality, so I'm not
inclined to take it unless Richard (as bitbake maintainer) feels that
an exception should be made.

In any event though, this was only accepted into master a week ago.  I
typically let patches "age" a bit there to see if problems crop up
before backporting.

Steve

> Would be really nice/make our lives easier if this could make it all the =
way into scarthgap, but understand if there is hesitation from the maintain=
ers.
>
> Thanks,
> -Eric
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17449): https://lists.openembedded.org/g/bitbake-deve=
l/message/17449
> Mute This Topic: https://lists.openembedded.org/mt/111638710/3620601
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [steve@=
sakoman.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

