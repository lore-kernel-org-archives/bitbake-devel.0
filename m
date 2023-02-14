Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BAC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:19:35 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.9597.1676387973765552464
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:19:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bIJz62OK;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id y1so16042154wru.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhtOBojnmrx0213DMvji7g573orp4zvnzP1XAUX1cdo=;
        b=bIJz62OKnmoun5KK0aMV7xxV4Pw/59ZUn6RuuuiLe8iHJ6hzjZxVFH7173+jEcnWnj
         bxTpx8MhgFYdYs89u0czhk9q5Ss1hua7SCsaRHWHB5c0sw6bvp9VLjBaifS7p6yxKSWw
         H0C3x88DLJmHree6DLhpVnbFI8dea+4bLWgPYsKfvV3UxKUHHamKCJY3t11uSVFQmPSl
         AdChqf7IRgOdayRr9fXKPKiy3VDVwMmcEQoIh6dVxEbmcfDBWKjAwr5xuwO1CAyqUiVX
         TLgJ58DZ4RHiSRW8BcuU3hVtVphGDiA8ZQi5uJbVX6LXx5d8aGvaOcVEz5yR7AXZNHHm
         i41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhtOBojnmrx0213DMvji7g573orp4zvnzP1XAUX1cdo=;
        b=E1lre92xacWlX1nICaPGWWBES9Mrs9cLlK04sR/7Yw1qYfKqn4ta3b5LO6wEQygCFb
         2KHfCM8jwvK1e9eISUcVWc40oNHfxEVo6+UHZo5L3SpCUGlZ1otn0L+4nePqOGC59lkD
         lC7boDg96WdVIGl4gzl8u+gNwvoSYdYSioIihPotBTDFycp0jMHb3HGJaCt6kVGgGTY+
         KRPHG/rfyz+RaQqfB0QvvJZsG5IYH+pgSKOIW/42Tko4dPR3bTlvAuYLqknGjbKbamSU
         Gb7mdCYTTL9I3Vb4mRWgZDOHzU4eCp7GykEyCAEM1KDjofHszA/yQuUQsf6j6UWHdWHw
         SoBg==
X-Gm-Message-State: AO0yUKVPLK6EVFFstoJ9kd7OYijYurIhtC5WbV3hppItI5vZZfsD1Iaa
	iyftYm8BGCYU+nLCkBc9SV/GH4d4alRaX5RAQQ0=
X-Google-Smtp-Source: AK7set+mLNU6XcB8oChB0dW0mzMs7L5yGj2J6cYDx1Gv/6rr8rz/JSU92o/CGNay3BndJbTzlRUbz1VNIGd8v2bEaVo=
X-Received: by 2002:a5d:570d:0:b0:2c5:5788:c516 with SMTP id
 a13-20020a5d570d000000b002c55788c516mr61666wrv.127.1676387971983; Tue, 14 Feb
 2023 07:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20230214103441.1516378-1-ecordonnier@snap.com>
 <CA+chaQcDfmRif6AEN-jAtBYy=fzXhnn6tNOVK7NmROG9k3XNdg@mail.gmail.com>
 <CAHUKmYaKHLi2OQS_JURzMfo=aMpjZmUZ16rxrq=2W6aMoE0weg@mail.gmail.com>
 <CAHUKmYbn95Mybr69s0WkU5a5j9c-2p-KbthrYqigTPwfis1q0Q@mail.gmail.com>
 <CA+chaQfQmppPAYvHxCH5F2O24QmunG8dyWvmD7CmNz3pmYGimQ@mail.gmail.com>
 <CAHUKmYaGb_4=YzhKrZxcSCeiNAOPTm2=yVM4KC9JP3c4HAmhBw@mail.gmail.com>
 <CAHUKmYaVGiWd1gDEcih=Yz6n9xjiFQtAsb6QDi6S9quJuUteog@mail.gmail.com>
 <CA+chaQc5PJYgRHQ_kTTuq62uh870SXAwAVx4OQVH9ui-K3WzgA@mail.gmail.com>
 <CAHUKmYaESjaPsuXSaCnsD_Jc4f9McnPCB-SoVZpcdTw+L=JPaA@mail.gmail.com>
 <CA+chaQd_ZjXdZ6yvDTn4xqGTeT0v1-gPn4ao=+GVJLyvuYgUPQ@mail.gmail.com>
 <CAHUKmYaQOADurM5Xg+rqjTMggnzJ+PNr_hBEv7O4+H0xeowmUA@mail.gmail.com>
 <CA+chaQfM_RtiC4iejTVQvfjxyF9ALRx=Q_kR1Rcir70Og0zRFQ@mail.gmail.com>
 <CAHUKmYYDQh6KpHyBwkDwYxadTnZAPmzGmGvsFmo=dXD_EGXa9Q@mail.gmail.com>
 <CAHUKmYadeSYGPeV8VWbDnA_YaXVmw--EYQf1aPNaK0_JX4nfyQ@mail.gmail.com>
 <CA+chaQcAF6uBDSRQcVffuiAo-aJGN2JM7x1C24-VXiRydX3kOw@mail.gmail.com>
 <CAHUKmYZbm0YhePfh+1icGv25fda0X8L2315zvY1Bgi-of+PN7A@mail.gmail.com>
 <CAHUKmYa3+w1NN5kGOcnwnoGS2yRQfPe6o2NHy3TDhV=OXe24hA@mail.gmail.com>
 <CAHUKmYY9rj+nfcxietZo6rPWfHd4Fbko3c5damyE3P+14Zvi3w@mail.gmail.com>
 <CA+chaQdm+h1FMAOTJtkiPwY3hcnXFMjmhKC56Z3Jzfoahogh9Q@mail.gmail.com> <CAHUKmYZ5DJtA4NFdisJsT2aJJQjXfqkcPbSZx_SEh6K7SS40Kg@mail.gmail.com>
In-Reply-To: <CAHUKmYZ5DJtA4NFdisJsT2aJJQjXfqkcPbSZx_SEh6K7SS40Kg@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 14 Feb 2023 16:19:20 +0100
Message-ID: <CA+chaQeCF2p4m3Ygos2YaA5i3sG5CrE5yLo3J5aW5YVUPqtUmA@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] siggen: fix inefficient
 string concatenation
To: Etienne Cordonnier <ecordonnier@snap.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000936c3505f4aa7d1d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:19:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14411

--000000000000936c3505f4aa7d1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2023 at 2:53 PM Etienne Cordonnier <ecordonnier@snap.com>
wrote:

> Yes, see my last email for the explanation of why 3.11 is slower when the
> code is not in a function. Let's use extend() instead of +=3D, this will =
be
> more portable (but as far as I understand, the code should already be fas=
t
> on your setup because it is called inside a function when called inside
> poky).
>

Thanks, I've seen it after sending my reply. Yes it explains why I'm seeing
it in my simple test case, but I'm surprised that it's not seen as
regression, true global variables were always a bit slower than local, but
this is significantly slower and the improvement from 3.12 doesn't return
the 3.10 performance (at least not in alpha5 I was testing).

Do you mind adding me as co-author of the patch?
>

No problem, but it's not ready
1) It causes a lot of warnings like:
WARNING: Runqueue deadlocked on deferred tasks, forcing task
virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-devtools/gn=
u-config/gnu-config_git.bb:do_populate_sysroot
blocked by
virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-devtools/gn=
u-config/gnu-config_git.bb:
do_deploy_source_date_epoch
and
NOTE: Deferring
virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-support/sql=
ite/sqlite3_3.40.1.bb:do_populate_sysroot
after
virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-support/sql=
ite/sqlite3_3.40.1.bb:
do_deploy_source_date_epoch

2) I still want to test it with externalsrc (measuring whole get_taskhash()
function), the bottleneck might still be there somewhere else - it took
almost 2 hours before, so only some portion of this was this for loop.

+ML again as some parts of this might be interesting to other as well.

Regards,

On Tue, Feb 14, 2023 at 2:48 PM Martin Jansa <martin.jansa@gmail.com> wrote=
:
>
>> Gentoo:
>> $ python3 --version
>> Python 3.11.2
>> $ ./test-with-both-times.py
>> +=3D took 507.63995265960693 seconds
>> extends() took 0.7833898067474365 seconds
>>
>> $ python3.10 test-with-both-times.py
>> +=3D took 0.2911818027496338 seconds
>> extends() took 0.7215933799743652 seconds
>>
>> $ pypy3.9 ./test-with-both-times.py
>> +=3D took 351.19071674346924 seconds
>> extends() took 0.9291989803314209 seconds
>>
>> Ubuntu-23.04 in docker:
>> $ python3 --version
>> Python 3.11.1
>> $ python3 test-with-both-times.py
>> +=3D took 509.31823468208313 seconds
>> extends() took 0.1940152645111084 seconds
>>
>> Ubuntu-22.04 in docker:
>> $ python3 --version
>> Python 3.10.4
>> $ python3 test-with-both-times.py
>> +=3D took 0.09383106231689453 seconds
>> extends() took 0.20920562744140625 seconds
>>
>> Current oe-core/master
>> $
>> /OE/build/oe-core/tmp-glibc/sysroots-components/x86_64/python3-native/us=
r/bin/python3-native/python3
>> --version
>> Python 3.11.1
>> $
>> /OE/build/oe-core/tmp-glibc/sysroots-components/x86_64/python3-native/us=
r/bin/python3-native/python3
>> test-with-both-times.py
>> +=3D took 508.69702982902527 seconds
>> extends() took 0.22980260848999023 seconds
>>
>> My host is busy but not that busy (load only ~ 5 now) :/
>>
>> Looks like 3.10 python was built with some secret sauce where the
>> optimization you mentioned worked, but it doesn't anymore with 3.11.
>>
>> I'm checking python 3.12-alpha5 in gentoo and I've noticed that PGO is
>> disabled in my build, but I don't expect it to have such huge impact, le=
ts
>> see.
>>
>> On Tue, Feb 14, 2023 at 2:00 PM Etienne Cordonnier <ecordonnier@snap.com=
>
>> wrote:
>>
>>> By the way, from a big picture point of view, I think using extends() i=
s
>>> still acceptable. Even on my setup where it's 100% slower than the +=3D
>>> version, it is still 500 times faster than the original version and
>>> therefore the function is not a bottleneck. It makes the code more port=
able
>>> and less dependent on a particular optimization of CPython, which is th=
e
>>> recommendation of PEP8 I quoted in my commit message.
>>>
>>> On Tue, Feb 14, 2023 at 1:55 PM Etienne Cordonnier <ecordonnier@snap.co=
m>
>>> wrote:
>>>
>>>> What do you get if you run this?
>>>>
>>>>
>>>> ecordonnier@lj8k2dq3:~$ python test-with-both-times.py
>>>> +=3D took 0.09932756423950195 seconds
>>>> extends() took 0.2495267391204834 seconds
>>>>
>>>> On Tue, Feb 14, 2023 at 1:53 PM Etienne Cordonnier <
>>>> ecordonnier@snap.com> wrote:
>>>>
>>>>> Yes, I also don't get why it's slower with extends. This contradicts
>>>>> the results of this test script attached where the version with exten=
ds is
>>>>> the faster:
>>>>>
>>>>> ecordonnier@lj8k2dq3:~$ python test2.py
>>>>> end loop2: 1.1121666431427002
>>>>> end loop4: 1.0626156330108643
>>>>> end loop5: 0.7910439968109131
>>>>>
>>>>>
>>>>> ecordonnier@lj8k2dq3:~$ ls -l checksums.json
>>>>> -rw-rw-r-- 1 ecordonnier ecordonnier 52554695 Feb 14 13:34
>>>>> checksums.json
>>>>> ecordonnier@lj8k2dq3:~$ du -h checksums.data
>>>>> 12M checksums.data
>>>>>
>>>>> On Tue, Feb 14, 2023 at 1:51 PM Martin Jansa <martin.jansa@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> That's weird, why does it use 512s on my host and only 0.09 on yours
>>>>>> :/
>>>>>> Were you using whole 51MB checksums.json with 12MB resulting file?
>>>>>>
>>>>>> $ du -h checksums.data
>>>>>> 12M     checksums.data
>>>>>>
>>>>>> On Tue, Feb 14, 2023 at 1:48 PM Etienne Cordonnier <
>>>>>> ecordonnier@snap.com> wrote:
>>>>>>
>>>>>>> Nevermind, the script is garbage after my modification. The correct
>>>>>>> time is 0.24 seconds for the "extends" version and 0.09 seconds for=
 the
>>>>>>> "+=3D" version.
>>>>>>>
>>>>>>> On Tue, Feb 14, 2023 at 1:45 PM Etienne Cordonnier <
>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>
>>>>>>>> Those are the results on my setup (I modified the script slightly)=
:
>>>>>>>>
>>>>>>>> $ python --version
>>>>>>>> Python 3.10.6
>>>>>>>> ecordonnier@lj8k2dq3:~$ python test.py
>>>>>>>> +=3D took 0.09993505477905273 seconds
>>>>>>>> extends() took 0.0006468296051025391 seconds
>>>>>>>>
>>>>>>>> On Tue, Feb 14, 2023 at 1:34 PM Martin Jansa <
>>>>>>>> martin.jansa@gmail.com> wrote:
>>>>>>>>
>>>>>>>>> > Do you have checksums.json?
>>>>>>>>>
>>>>>>>>> Link to it was in previous mail
>>>>>>>>>
>>>>>>>>> 51MB checksums.json:
>>>>>>>>>
>>>>>>>>> https://drive.google.com/file/d/1tA24mXF7cJ8RonoevFmU_7n4xh9k1KoS=
/view?usp=3Dsharing
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Tue, Feb 14, 2023 at 1:33 PM Etienne Cordonnier <
>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>
>>>>>>>>>> I wonder why the optimization with "+=3D" is not working as yoct=
o
>>>>>>>>>> patch on your setup even though it works on your setup with
>>>>>>>>>> "concatenate.py".
>>>>>>>>>>
>>>>>>>>>> Do you have checksums.json?
>>>>>>>>>>
>>>>>>>>>> On Tue, Feb 14, 2023 at 1:21 PM Martin Jansa <
>>>>>>>>>> martin.jansa@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>>> The approach with array seems way to go it went down from 512s
>>>>>>>>>>> to 0.767s (both with loaded host). It produced the same result =
as expected
>>>>>>>>>>> (but I the paths I have have no /./).
>>>>>>>>>>>
>>>>>>>>>>> Can you test this on your host with older python3?
>>>>>>>>>>>
>>>>>>>>>>> If it works similarly for you, then we can use this to fix
>>>>>>>>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14942
>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzill=
a.yoctoproject.org_show-5Fbug.cgi-3Fid-3D14942&d=3DDwMFaQ&c=3DncDTmphkJTvjI=
DPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m=
67E&m=3Du28ErN8vnQyB_3KruKe2A4aqRS4PBeCVjnIYNr0wAAvki8gZJWo_6ObIH7YCgvVN&s=
=3DNE0gvBMLDj8hPL8pFnfwoyE7f3zS5Kwj44TjfiYc5S0&e=3D>
>>>>>>>>>>>
>>>>>>>>>>> #!/usr/bin/env python3
>>>>>>>>>>>
>>>>>>>>>>> import json
>>>>>>>>>>>
>>>>>>>>>>> data =3D ''
>>>>>>>>>>> with open('checksums.json', "r") as f:
>>>>>>>>>>>     checksums =3D json.load(f)
>>>>>>>>>>> import time
>>>>>>>>>>> start_time =3D time.time()
>>>>>>>>>>> datalist =3D []
>>>>>>>>>>> for (f, cs) in checksums:
>>>>>>>>>>>     if cs:
>>>>>>>>>>>         # 1018.7424070835114s
>>>>>>>>>>>         # data +=3D cs
>>>>>>>>>>>
>>>>>>>>>>>         # 1061.4139277935028
>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>
>>>>>>>>>>>         # 1020.9841980934143
>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>         #     data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>
>>>>>>>>>>>         # Test again 2023-02-14
>>>>>>>>>>>         # took 1076.6172671318054 seconds
>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>
>>>>>>>>>>>         # took 699.0907781124115 seconds
>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>         #     data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>
>>>>>>>>>>>         # took 582.110622882843 seconds
>>>>>>>>>>>         # took 512.9146637916565 seconds
>>>>>>>>>>>         if "/./" in f:
>>>>>>>>>>>             data +=3D "./" + f.split("/./")[1]
>>>>>>>>>>>         data +=3D cs
>>>>>>>>>>>
>>>>>>>>>>>         # took 546.2394247055054 seconds
>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>         #     data +=3D "./"
>>>>>>>>>>>         #     data +=3D f.split("/./")[1]
>>>>>>>>>>>         # data +=3D cs
>>>>>>>>>>>
>>>>>>>>>>> #         took 0.7674515247344971 seconds
>>>>>>>>>>> #         if "/./" in f:
>>>>>>>>>>> #             datalist.extend(("./", f.split("/./")[1]))
>>>>>>>>>>> #         datalist.extend(cs)
>>>>>>>>>>> # data =3D "".join(datalist)
>>>>>>>>>>>
>>>>>>>>>>> stop_time =3D time.time()
>>>>>>>>>>> print("took %s seconds" % (stop_time - start_time))
>>>>>>>>>>>
>>>>>>>>>>> with open('checksums.data', "w") as f:
>>>>>>>>>>>     f.write(data)
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Feb 14, 2023 at 1:07 PM Etienne Cordonnier <
>>>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>> OK, I'm on Ubuntu 22.04, with python 3.10.6 (based on CPython)
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:36 PM Martin Jansa <
>>>>>>>>>>>> martin.jansa@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> OK,
>>>>>>>>>>>>>
>>>>>>>>>>>>> FWIW: There is no difference between loop2 and loop3 on mine:
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ python3 concatenate.py
>>>>>>>>>>>>> begin: 1676374316.6670556
>>>>>>>>>>>>> end loop1: 5.00896430015564
>>>>>>>>>>>>> end loop2: 0.7002358436584473
>>>>>>>>>>>>> end loop3: 0.7122139930725098
>>>>>>>>>>>>> $ python3 --version
>>>>>>>>>>>>> Python 3.11.2
>>>>>>>>>>>>>
>>>>>>>>>>>>> These are the versions I plan to test (faster 2nd loop might
>>>>>>>>>>>>> be caused by less load of the host during the run - which I w=
hy I wanted to
>>>>>>>>>>>>> wait for builds to finish first):
>>>>>>>>>>>>>
>>>>>>>>>>>>>         # Test again 2023-02-14
>>>>>>>>>>>>>         # took 1076.6172671318054 seconds
>>>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>>>
>>>>>>>>>>>>>         # took 699.0907781124115 seconds
>>>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>>>         #     data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>>>
>>>>>>>>>>>>>         if "/./" in f:
>>>>>>>>>>>>>             data +=3D "./" + f.split("/./")[1]
>>>>>>>>>>>>>         data +=3D cs
>>>>>>>>>>>>>
>>>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>>>         #     data +=3D "./"
>>>>>>>>>>>>>         #     data +=3D f.split("/./")[1]
>>>>>>>>>>>>>         # data +=3D cs
>>>>>>>>>>>>>
>>>>>>>>>>>>> #        if "/./" in f:
>>>>>>>>>>>>> #            datalist.extend(("./", f.split("/./")[1]))
>>>>>>>>>>>>> #        datalist.extend(cs)
>>>>>>>>>>>>> #data =3D "".join(datalist)
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:30 PM Etienne Cordonnier <
>>>>>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> For instance on my linux machine:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> $ python concatenate.py /usr
>>>>>>>>>>>>>> begin: 1676374195.3408449
>>>>>>>>>>>>>> end loop1: 3.8941030502319336
>>>>>>>>>>>>>> end loop2: 0.026114225387573242
>>>>>>>>>>>>>> end loop3: 0.8803601264953613
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:28 PM Etienne Cordonnier <
>>>>>>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> "I'm surprised if
>>>>>>>>>>>>>>> -data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>>> +data +=3D "./" + f.split("/./")[1]
>>>>>>>>>>>>>>> shows any significant improvement,"
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> -> It is surprising indeed, but it shows a fully
>>>>>>>>>>>>>>> reproducible massive improvement on my setup because of thi=
s CPython
>>>>>>>>>>>>>>> optimization (I have a directory in SRC_URI with 70K files,=
 however I'm not
>>>>>>>>>>>>>>> using externalsrc). You can see that it is also fully repro=
ducible with a
>>>>>>>>>>>>>>> generic test python script (the benchmark script I shared i=
n
>>>>>>>>>>>>>>> https://stackoverflow.com/q/75313204/1710392
>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sta=
ckoverflow.com_q_75313204_1710392&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHv=
abgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dgt-ty=
vzhSf7FdU4C_i2N28p3HBcbuG1YK7V2zRfzMRyccJoUdOu3Mgd9-FEDkJ27&s=3DExrYHlBJDdI=
xPj1Mt10Pl1_Yzsq6c8OWoUXDXyW2l48&e=3D>
>>>>>>>>>>>>>>> ).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:24 PM Martin Jansa <
>>>>>>>>>>>>>>> martin.jansa@gmail.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi Etienne,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm didn't notice that this was already merged in master.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm surprised if
>>>>>>>>>>>>>>>> -data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>> +data +=3D "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>> shows any significant improvement, because that's what I
>>>>>>>>>>>>>>>> was testing before when working on:
>>>>>>>>>>>>>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14942
>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bu=
gzilla.yoctoproject.org_show-5Fbug.cgi-3Fid-3D14942&d=3DDwMFaQ&c=3DncDTmphk=
JTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkS=
Ga66m67E&m=3DHPBNj1QO1qPbzf1RJ4lAV7mnwD4_jzP_YHYEg6vvnJs-ws8Hyh5xTgTYHnjbXl=
OZ&s=3DOvBJbC8LaGfBfX3f9OMXk24rW24sXFje0wa14nh_xPo&e=3D>
>>>>>>>>>>>>>>>> and it made no difference, I was assuming that you'll need
>>>>>>>>>>>>>>>> to split it as:
>>>>>>>>>>>>>>>> data +=3D "./"
>>>>>>>>>>>>>>>> data +=3D f.split("/./")[1]
>>>>>>>>>>>>>>>> to trigger that optimalization.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This is the simplified test I'm using to simulate
>>>>>>>>>>>>>>>> externalsrc.bbclass on huge repo (with those 380227 paths)=
:
>>>>>>>>>>>>>>>> 51MB checksums.json:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> https://drive.google.com/file/d/1tA24mXF7cJ8RonoevFmU_7n4x=
h9k1KoS/view?usp=3Dsharing
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> And the "test" (haven't updated it yet, because the host i=
s
>>>>>>>>>>>>>>>> busy with building many things ATM).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> #!/usr/bin/env python3
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> import json
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> data =3D ''
>>>>>>>>>>>>>>>> with open('checksums.json', "r") as f:
>>>>>>>>>>>>>>>>     checksums =3D json.load(f)
>>>>>>>>>>>>>>>> import time
>>>>>>>>>>>>>>>> start_time =3D time.time()
>>>>>>>>>>>>>>>> for (f, cs) in checksums:
>>>>>>>>>>>>>>>>     if cs:
>>>>>>>>>>>>>>>>         # 1018.7424070835114s
>>>>>>>>>>>>>>>>         # data +=3D cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>         # 1061.4139277935028
>>>>>>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>         # 1020.9841980934143
>>>>>>>>>>>>>>>>         # if "/./" in f:
>>>>>>>>>>>>>>>>         #     data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>         # Test again 2023-02-14
>>>>>>>>>>>>>>>>         # took 1076.6172671318054 seconds
>>>>>>>>>>>>>>>>         # data =3D data + cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>         if "/./" in f:
>>>>>>>>>>>>>>>>             data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>>         data =3D data + cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> #        if "/./" in f:
>>>>>>>>>>>>>>>> #            data +=3D "./"
>>>>>>>>>>>>>>>> #            data +=3D f.split("/./")[1]
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> #        if "/./" in f:
>>>>>>>>>>>>>>>> #            data +=3D "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>> #        data =3D data + cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> #       data +=3D cs
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> stop_time =3D time.time()
>>>>>>>>>>>>>>>> print("took %s seconds" % (stop_time - start_time))
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:15 PM Etienne Cordonnier <
>>>>>>>>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi Martin, I don't want to spam the mailing list, but
>>>>>>>>>>>>>>>>> basically you can try to replace this line:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> -                    data =3D data + "./" + f.split("/./"=
)[1]
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> With those lines:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> + datalist =3D []
>>>>>>>>>>>>>>>>> ....
>>>>>>>>>>>>>>>>> +  datalist.extend(("./", f.split("/./")[1]))
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> + datalist =3D "".join(datalist)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> And then you need to append datalist to data.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I think it could be even faster than my patch, but for my=
 test-case this part of the code doesn't seem to be the bottleneck any more=
 anyway, so I don't think I'll spend more time testing this.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 12:04 PM Etienne Cordonnier <
>>>>>>>>>>>>>>>>> ecordonnier@snap.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Note that this is just a cherry-pick from the main
>>>>>>>>>>>>>>>>>> branch, so I kept the commit exactly identical.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> However in case your test-case is still slow, I believe
>>>>>>>>>>>>>>>>>> there is a potential for speed optimization by creating =
a list and then
>>>>>>>>>>>>>>>>>> calling join() one time once the loop is finished ("loop=
 5" in
>>>>>>>>>>>>>>>>>> https://stackoverflow.com/a/75313327/1710392
>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
stackoverflow.com_a_75313327_1710392&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DHP=
BNj1QO1qPbzf1RJ4lAV7mnwD4_jzP_YHYEg6vvnJs-ws8Hyh5xTgTYHnjbXlOZ&s=3DGdb2DQUO=
f6peT_9enI2SqvbqHXMOmYziGjtNQHkmPXs&e=3D>
>>>>>>>>>>>>>>>>>> ). Of course the memory usage would increase, but it's a=
 trade-off.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 11:57 AM Martin Jansa <
>>>>>>>>>>>>>>>>>> martin.jansa@gmail.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> This might help with:
>>>>>>>>>>>>>>>>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D149=
42
>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_bugzilla.yoctoproject.org_show-5Fbug.cgi-3Fid-3D14942&d=3DDwMFaQ&c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTK=
UkSGa66m67E&m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc=
4mUN5&s=3DyeRxgb5569zYnhHWpVFzs4fvU9NrVNah2UOPePY64Rs&e=3D>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> will test it on my testcase with 380227 paths and updat=
e
>>>>>>>>>>>>>>>>>>> the ticket if this helps.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 11:35 AM ecordonnier via
>>>>>>>>>>>>>>>>>>> lists.openembedded.org
>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__=
lists.openembedded.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2ep=
ckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DoiN1UiZT6K3vh9RW=
Ch9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DURKYJE0IqTwSkkx42HBRLJ=
E5BsC41VfpRdhus8DX5xY&e=3D>
>>>>>>>>>>>>>>>>>>> <ecordonnier=3Dsnap.com@lists.openembedded.org> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> From: Etienne Cordonnier <ecordonnier@snap.com>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> As discussed in
>>>>>>>>>>>>>>>>>>>> https://stackoverflow.com/a/4435752/1710392
>>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__stackoverflow.com_a_4435752_1710392&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4=
vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Do=
iN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DQpRKrH6=
Ih3NfErHKEJ3_t6yojMBxhRvk66sn4Gsazkw&e=3D>
>>>>>>>>>>>>>>>>>>>> , CPython
>>>>>>>>>>>>>>>>>>>> has an optimization for statements in the form "a =3D =
a +
>>>>>>>>>>>>>>>>>>>> b" or "a +=3D b".
>>>>>>>>>>>>>>>>>>>> It seems that this line does not get optimized, becaus=
e
>>>>>>>>>>>>>>>>>>>> it has a form a =3D a + b + c:
>>>>>>>>>>>>>>>>>>>> data =3D data + "./" + f.split("/./")[1]
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> For that reason, it does a copy of data for each
>>>>>>>>>>>>>>>>>>>> iteration, potentially copying megabytes
>>>>>>>>>>>>>>>>>>>> of data for each iteration.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Changing this line causes
>>>>>>>>>>>>>>>>>>>> SignatureGeneratorBasic::get_taskhash to take 0.06 sec=
onds
>>>>>>>>>>>>>>>>>>>> instead of 45 seconds on my test setup where SRC_URI
>>>>>>>>>>>>>>>>>>>> points to a big directory.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Note that PEP8 recommends explicitely not to use this
>>>>>>>>>>>>>>>>>>>> optimization which is specific to CPython:
>>>>>>>>>>>>>>>>>>>> "do not rely on CPython=E2=80=99s efficient implementa=
tion of
>>>>>>>>>>>>>>>>>>>> in-place string concatenation for statements in the fo=
rm a +=3D b or a =3D a +
>>>>>>>>>>>>>>>>>>>> b"
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> However, the PEP8 recommended form using "join()" also
>>>>>>>>>>>>>>>>>>>> does not avoid the copy and takes 45 seconds in my tes=
t setup:
>>>>>>>>>>>>>>>>>>>> data =3D ''.join((data, "./", f.split("/./")[1]))
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I have changed the other lines to also use +=3D for
>>>>>>>>>>>>>>>>>>>> consistency only, however those were in the form a =3D=
 a + b
>>>>>>>>>>>>>>>>>>>> and were optimized already.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Co-authored-by: JJ Robertson <jrobertson@snap.com>
>>>>>>>>>>>>>>>>>>>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.co=
m
>>>>>>>>>>>>>>>>>>>> >
>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>  lib/bb/siggen.py | 10 +++++-----
>>>>>>>>>>>>>>>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
>>>>>>>>>>>>>>>>>>>> index 130b38d8..2381edd2 100644
>>>>>>>>>>>>>>>>>>>> --- a/lib/bb/siggen.py
>>>>>>>>>>>>>>>>>>>> +++ b/lib/bb/siggen.py
>>>>>>>>>>>>>>>>>>>> @@ -328,19 +328,19 @@ class
>>>>>>>>>>>>>>>>>>>> SignatureGeneratorBasic(SignatureGenerator):
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>          data =3D self.basehash[tid]
>>>>>>>>>>>>>>>>>>>>          for dep in self.runtaskdeps[tid]:
>>>>>>>>>>>>>>>>>>>> -            data =3D data + self.get_unihash(dep)
>>>>>>>>>>>>>>>>>>>> +            data +=3D self.get_unihash(dep)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>          for (f, cs) in self.file_checksum_values[tid]=
:
>>>>>>>>>>>>>>>>>>>>              if cs:
>>>>>>>>>>>>>>>>>>>>                  if "/./" in f:
>>>>>>>>>>>>>>>>>>>> -                    data =3D data + "./" +
>>>>>>>>>>>>>>>>>>>> f.split("/./")[1]
>>>>>>>>>>>>>>>>>>>> -                data =3D data + cs
>>>>>>>>>>>>>>>>>>>> +                    data +=3D "./" + f.split("/./")[1=
]
>>>>>>>>>>>>>>>>>>>> +                data +=3D cs
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>          if tid in self.taints:
>>>>>>>>>>>>>>>>>>>>              if self.taints[tid].startswith("nostamp:"=
):
>>>>>>>>>>>>>>>>>>>> -                data =3D data + self.taints[tid][8:]
>>>>>>>>>>>>>>>>>>>> +                data +=3D self.taints[tid][8:]
>>>>>>>>>>>>>>>>>>>>              else:
>>>>>>>>>>>>>>>>>>>> -                data =3D data + self.taints[tid]
>>>>>>>>>>>>>>>>>>>> +                data +=3D self.taints[tid]
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>          h =3D
>>>>>>>>>>>>>>>>>>>> hashlib.sha256(data.encode("utf-8")).hexdigest()
>>>>>>>>>>>>>>>>>>>>          self.taskhash[tid] =3D h
>>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>>> 2.36.1.vfs.0.0
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>>>>>>>>>>>>>>>>> Links: You receive all messages sent to this group.
>>>>>>>>>>>>>>>>>>>> View/Reply Online (#14404):
>>>>>>>>>>>>>>>>>>>> https://lists.openembedded.org/g/bitbake-devel/message=
/14404
>>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__lists.openembedded.org_g_bitbake-2Ddevel_message_14404&d=3DDwMFaQ&c=3DncD=
TmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJ=
TKUkSGa66m67E&m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLE=
Oc4mUN5&s=3DVw-mNHnRPLvPlWEXUYciNNhBB4pZanI2ZGEsbWRNR-g&e=3D>
>>>>>>>>>>>>>>>>>>>> Mute This Topic:
>>>>>>>>>>>>>>>>>>>> https://lists.openembedded.org/mt/96957072/3617156
>>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__lists.openembedded.org_mt_96957072_3617156&d=3DDwMFaQ&c=3DncDTmphkJTvjIDP=
h0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67=
E&m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3D=
l4fkRs6786x3hj5GGhT8XQ30SmRozQ8PJGoP_xPn_y0&e=3D>
>>>>>>>>>>>>>>>>>>>> Group Owner: bitbake-devel+owner@lists.openembedded.or=
g
>>>>>>>>>>>>>>>>>>>> Unsubscribe:
>>>>>>>>>>>>>>>>>>>> https://lists.openembedded.org/g/bitbake-devel/unsub
>>>>>>>>>>>>>>>>>>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__lists.openembedded.org_g_bitbake-2Ddevel_unsub&d=3DDwMFaQ&c=3DncDTmphkJTv=
jIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa6=
6m67E&m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&=
s=3DDVQKHhGOkYy3oSbWagenl7KtRRYBC1655FauLxtgkHw&e=3D>
>>>>>>>>>>>>>>>>>>>> [Martin.Jansa@gmail.com]
>>>>>>>>>>>>>>>>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>

--000000000000936c3505f4aa7d1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Feb 14, 2023 at 2:53 PM Etienne C=
ordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com">ecordonnier@snap.com<=
/a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr">Yes, see my last email for the e=
xplanation of why 3.11 is slower when the code is not in a function. Let&#3=
9;s use extend() instead of=C2=A0+=3D, this will be more portable (but as f=
ar as I understand, the code should already be fast on your setup because i=
t is called inside a function when called inside poky).</div></blockquote><=
div><br></div><div>Thanks, I&#39;ve seen it after sending my reply. Yes it =
explains why I&#39;m seeing it in my simple test case, but I&#39;m surprise=
d that it&#39;s not seen as regression, true global variables were always a=
 bit slower than local, but this is significantly slower and the improvemen=
t from 3.12 doesn&#39;t return the 3.10 performance (at least not in alpha5=
 I was testing).</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Do you mind adding me as co-author of the patc=
h?</div></blockquote><div><br></div><div>No problem, but it&#39;s not ready=
</div><div>1) It causes a lot of warnings like:</div><div>WARNING: Runqueue=
 deadlocked on deferred tasks, forcing task virtual:native:/OE/build/oe-cor=
e/openembedded-core/meta/recipes-devtools/gnu-config/gnu-config_git.bb:do_p=
opulate_sysroot blocked by virtual:native:/OE/build/oe-core/openembedded-co=
re/meta/recipes-devtools/gnu-config/gnu-config_git.bb:do_deploy_source_date=
_epoch<br></div><div>and</div><div>NOTE: Deferring virtual:native:/OE/build=
/oe-core/openembedded-core/meta/recipes-support/sqlite/sqlite3_3.40.1.bb:do=
_populate_sysroot after virtual:native:/OE/build/oe-core/openembedded-core/=
meta/recipes-support/sqlite/sqlite3_3.40.1.bb:do_deploy_source_date_epoch<b=
r></div><div><br></div><div>2) I still want to test it with externalsrc (me=
asuring whole=C2=A0get_taskhash() function), the bottleneck might still be =
there somewhere else - it took almost 2 hours before, so only some portion =
of this was this for loop.</div><div><br></div><div>+ML again as some parts=
 of this might be interesting to other as well.<br></div><div><br></div><di=
v>Regards,</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Feb 14, 2023 at 2:48 PM Martin Jansa &lt;<a href=3D"mailto:martin.jansa=
@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Gentoo=
:<div>$ python3 --version<br>Python 3.11.2<br></div><div>$ ./test-with-both=
-times.py<br>+=3D took 507.63995265960693 seconds<br>extends() took 0.78338=
98067474365 seconds<br></div><div><br></div><div>$ python3.10 test-with-bot=
h-times.py <br>+=3D took 0.2911818027496338 seconds<br>extends() took 0.721=
5933799743652 seconds<br></div><div><br></div><div>$ pypy3.9 ./test-with-bo=
th-times.py<br>+=3D took 351.19071674346924 seconds<br>extends() took 0.929=
1989803314209 seconds<br></div><div><br></div><div>Ubuntu-23.04 in docker:<=
/div><div>$ python3 --version<br>Python 3.11.1<br></div><div>$ python3 test=
-with-both-times.py<br></div><div>+=3D took 509.31823468208313 seconds</div=
><div>extends() took 0.1940152645111084 seconds<br></div><div><br></div><di=
v>Ubuntu-22.04 in docker:</div><div>$ python3 --version<br>Python 3.10.4<br=
></div><div>$ python3 test-with-both-times.py<br></div><div>+=3D took 0.093=
83106231689453 seconds<br>extends() took 0.20920562744140625 seconds<br></d=
iv><div><br></div><div>Current oe-core/master</div><div>$ /OE/build/oe-core=
/tmp-glibc/sysroots-components/x86_64/python3-native/usr/bin/python3-native=
/python3 --version<br>Python 3.11.1<br></div><div>$ /OE/build/oe-core/tmp-g=
libc/sysroots-components/x86_64/python3-native/usr/bin/python3-native/pytho=
n3 test-with-both-times.py<br></div><div>+=3D took 508.69702982902527 secon=
ds<br>extends() took 0.22980260848999023 seconds<br></div><div><br></div><d=
iv>My host is busy but not that busy (load only ~ 5 now) :/</div><div><br><=
/div><div>Looks like 3.10 python was built with some secret sauce where the=
 optimization you mentioned worked, but it doesn&#39;t anymore with 3.11.</=
div><div><br></div><div>I&#39;m checking python 3.12-alpha5 in gentoo and I=
&#39;ve noticed that PGO is disabled in my build, but I don&#39;t expect it=
 to have such huge impact, lets see.</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at 2:00 PM E=
tienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_bl=
ank">ecordonnier@snap.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr">By the way, from a big picture po=
int of view, I think using extends() is still acceptable. Even on my setup =
where it&#39;s 100% slower than the=C2=A0+=3D version, it is still 500 time=
s faster than the original version and therefore the function is not a bott=
leneck. It makes the code more portable and less dependent on a particular =
optimization of CPython, which is the recommendation of PEP8 I quoted in my=
 commit message.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Feb 14, 2023 at 1:55 PM Etienne Cordonnier &lt;<a h=
ref=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">What do you get if you run this?<br><br><br>ecordonnier@lj8=
k2dq3:~$ python test-with-both-times.py <br>+=3D took 0.09932756423950195 s=
econds<br>extends() took 0.2495267391204834 seconds<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023=
 at 1:53 PM Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" =
target=3D"_blank">ecordonnier@snap.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Yes, I also don&#39;=
t get why it&#39;s slower with extends. This contradicts the results of thi=
s test script attached where the version with extends is the faster:<br><br=
>ecordonnier@lj8k2dq3:~$ python test2.py <br>end loop2: 1.1121666431427002 =
<br>end loop4: 1.0626156330108643 <br>end loop5: 0.7910439968109131 <br><br=
><br>ecordonnier@lj8k2dq3:~$ ls -l checksums.json <br>-rw-rw-r-- 1 ecordonn=
ier ecordonnier 52554695 Feb 14 13:34 checksums.json<br>ecordonnier@lj8k2dq=
3:~$ du -h checksums.data <br>12M	checksums.data<br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at=
 1:51 PM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" target=
=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr">That&#39;s weird, why do=
es it use 512s on my host and only 0.09 on yours :/<div>Were you using whol=
e 51MB checksums.json with 12MB resulting file?</div><div><br></div><div>$ =
du -h checksums.data<br>12M =C2=A0 =C2=A0 checksums.data<br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, F=
eb 14, 2023 at 1:48 PM Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier=
@snap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Nevermind=
, the script is garbage after my modification. The correct time is 0.24 sec=
onds for the &quot;extends&quot; version and 0.09 seconds for the &quot;+=
=3D&quot; version.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Feb 14, 2023 at 1:45 PM Etienne Cordonnier &lt;<a=
 href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr">Those are the results on my setup (I modified the script =
slightly):<br><br>$ python --version<br>Python 3.10.6<br>ecordonnier@lj8k2d=
q3:~$ python test.py <br>+=3D took 0.09993505477905273 seconds<br>extends()=
 took 0.0006468296051025391 seconds<br></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at 1:34 PM Mart=
in Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">ma=
rtin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr">&gt; Do you have checksums.json?<div><=
br></div><div>Link to it was in previous mail</div><div><br></div><div><div=
 style=3D"color:rgb(80,0,80)">51MB checksums.json:</div><div style=3D"color=
:rgb(80,0,80)"><a href=3D"https://drive.google.com/file/d/1tA24mXF7cJ8Ronoe=
vFmU_7n4xh9k1KoS/view?usp=3Dsharing" target=3D"_blank">https://drive.google=
.com/file/d/1tA24mXF7cJ8RonoevFmU_7n4xh9k1KoS/view?usp=3Dsharing</a></div><=
/div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Feb 14, 2023 at 1:33 PM Etienne Cordonnier &lt;=
<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr">I wonder why the optimization with &quot;+=3D&quot; is =
not working as yocto patch on your setup even though it works on your setup=
 with &quot;concatenate.py&quot;.<br><br>Do you have checksums.json?</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue,=
 Feb 14, 2023 at 1:21 PM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gm=
ail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>The =
approach with array seems way to go it went down from 512s to=C2=A00.767s (=
both with loaded host). It produced the same result as expected (but I the =
paths I have have no /./).</div><div><br></div><div>Can you test this on yo=
ur host with older python3?</div><div><br></div><div>If it works similarly =
for you, then we can use this to fix</div><div><a href=3D"https://urldefens=
e.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.yoctoproject.org_show-5Fbug.=
cgi-3Fid-3D14942&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2=
epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Du28ErN=
8vnQyB_3KruKe2A4aqRS4PBeCVjnIYNr0wAAvki8gZJWo_6ObIH7YCgvVN&amp;s=3DNE0gvBML=
Dj8hPL8pFnfwoyE7f3zS5Kwj44TjfiYc5S0&amp;e=3D" target=3D"_blank">https://bug=
zilla.yoctoproject.org/show_bug.cgi?id=3D14942</a><br></div><div><br></div>=
#!/usr/bin/env python3<br><br>import json<br><br>data =3D &#39;&#39;<br>wit=
h open(&#39;checksums.json&#39;, &quot;r&quot;) as f:<br>=C2=A0 =C2=A0 chec=
ksums =3D json.load(f)<br>import time<br>start_time =3D time.time()<br>data=
list =3D []<br>for (f, cs) in checksums:<br>=C2=A0 =C2=A0 if cs:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # 1018.7424070835114s<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=
 data +=3D cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # 1061.4139277935028<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # 1020.9841980934143<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if &quot;/=
./&quot; in f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A0 data =3D data=
 + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Test again 20=
23-02-14<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # took 1076.6172671318054 seconds<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # took 699.0907781124115 seconds<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
# if &quot;/./&quot; in f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A0 d=
ata =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=
 took 582.110622882843 seconds<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # took 512.91=
46637916565 seconds<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;/./&quot; in f:=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D &quot;./&quot; + f.=
split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D cs<br><b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # took 546.2394247055054 seconds<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # if &quot;/./&quot; in f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # =C2=A0 =C2=A0 data +=3D &quot;./&quot; <br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # =C2=A0 =C2=A0 data +=3D f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # data +=3D cs<br><br># =C2=A0 =C2=A0 =C2=A0 =C2=A0 took 0.76=
74515247344971 seconds<br># =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;/./&quot; =
in f:<br># =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 datalist.extend((&quot=
;./&quot;, f.split(&quot;/./&quot;)[1]))<br># =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
atalist.extend(cs)<br># data =3D &quot;&quot;.join(datalist)<br><br>stop_ti=
me =3D time.time()<br>print(&quot;took %s seconds&quot; % (stop_time - star=
t_time))<br><br>with open(&#39;checksums.data&#39;, &quot;w&quot;) as f:<br=
>=C2=A0 =C2=A0 f.write(data)<br></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at 1:07 PM Etienne Cor=
donnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecord=
onnier@snap.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr">OK, I&#39;m on Ubuntu 22.04, with python 3.=
10.6 (based on CPython)</div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Tue, Feb 14, 2023 at 12:36 PM Martin Jansa &lt;<a=
 href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmai=
l.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div>OK,</div><div><br></div><div>FWIW: There is no d=
ifference between loop2 and loop3 on mine:</div><div><br></div>$ python3 co=
ncatenate.py<br>begin: 1676374316.6670556 <br>end loop1: 5.00896430015564 <=
br>end loop2: 0.7002358436584473 <br>end loop3: 0.7122139930725098 <br>$ py=
thon3 --version<br>Python 3.11.2<br><div><br></div><div>These are the versi=
ons I plan to test (faster 2nd loop might be caused by less load of the hos=
t during the run - which I why I wanted to wait for builds to finish first)=
:</div><div><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Test again 2023-02-14<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 # took 1076.6172671318054 seconds<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # to=
ok 699.0907781124115 seconds<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if &quot;/./&=
quot; in f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A0 data =3D data + =
&quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # data =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;/./&quot;=
 in f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D &quot;./&quot=
; + f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D cs=
<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if &quot;/./&quot; in f:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A0 data +=3D &quot;./&quot; <br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # =C2=A0 =C2=A0 data +=3D f.split(&quot;/./&quot;)[1]<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data +=3D cs<br><br># =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if &quot;/./&quot; in f:<br># =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0datalist.extend((&quot;./&quot;, f.split(&quot;/./&quot;)[1]))<br># =C2=
=A0 =C2=A0 =C2=A0 =C2=A0datalist.extend(cs)<br>#data =3D &quot;&quot;.join(=
datalist)<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Feb 14, 2023 at 12:30 PM Etienne Cordonnier &lt;=
<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr">For instance on my linux machine:<br><br>$ python conca=
tenate.py /usr<br>begin: 1676374195.3408449 <br>end loop1: 3.89410305023193=
36 <br>end loop2: 0.026114225387573242 <br>end loop3: 0.8803601264953613=C2=
=A0<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Feb 14, 2023 at 12:28 PM Etienne Cordonnier &lt;<a href=3D"m=
ailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">&quot;I&#39;m surprised if<br>-data =3D data + &quot;./&quot; + f.=
split(&quot;/./&quot;)[1]<br>+data +=3D &quot;./&quot; + f.split(&quot;/./&=
quot;)[1]<br>shows any significant improvement,&quot;<br><br>-&gt; It is su=
rprising indeed, but it shows a fully reproducible massive improvement on m=
y setup because of this CPython optimization (I have a directory in SRC_URI=
 with 70K files, however I&#39;m not using=C2=A0externalsrc). You can see t=
hat it is also fully reproducible with a generic test python script (the be=
nchmark script I shared in=C2=A0<a href=3D"https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__stackoverflow.com_q_75313204_1710392&amp;d=3DDwMFaQ&=
amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfP=
x_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dgt-tyvzhSf7FdU4C_i2N28p3HBcbuG1YK7V2zR=
fzMRyccJoUdOu3Mgd9-FEDkJ27&amp;s=3DExrYHlBJDdIxPj1Mt10Pl1_Yzsq6c8OWoUXDXyW2=
l48&amp;e=3D" target=3D"_blank">https://stackoverflow.com/q/75313204/171039=
2</a> ).</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Feb 14, 2023 at 12:24 PM Martin Jansa &lt;<a href=3D"mailto=
:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">Hi Etienne,<div><br></div><div>I&#39;m didn&#39;t notice that this=
 was already merged in master.</div><div><br></div><div>I&#39;m surprised i=
f<br>-data =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>+data=
 +=3D &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>shows any significant=
 improvement, because that&#39;s what I was testing before when working on:=
</div><div><a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__bugzilla.yoctoproject.org_show-5Fbug.cgi-3Fid-3D14942&amp;d=3DDwMFaQ&amp;=
c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj=
9TsRih1DULJTKUkSGa66m67E&amp;m=3DHPBNj1QO1qPbzf1RJ4lAV7mnwD4_jzP_YHYEg6vvnJ=
s-ws8Hyh5xTgTYHnjbXlOZ&amp;s=3DOvBJbC8LaGfBfX3f9OMXk24rW24sXFje0wa14nh_xPo&=
amp;e=3D" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?=
id=3D14942</a></div><div>and it made no difference, I was assuming that you=
&#39;ll need to split it as:<br></div><div>data +=3D &quot;./&quot;<br></di=
v><div>data +=3D f.split(&quot;/./&quot;)[1]<br></div><div>to trigger that =
optimalization.</div><div><br></div><div>This is the simplified test I&#39;=
m using to simulate externalsrc.bbclass on huge repo (with those=C2=A038022=
7 paths):</div><div>51MB checksums.json:</div><div><a href=3D"https://drive=
.google.com/file/d/1tA24mXF7cJ8RonoevFmU_7n4xh9k1KoS/view?usp=3Dsharing" ta=
rget=3D"_blank">https://drive.google.com/file/d/1tA24mXF7cJ8RonoevFmU_7n4xh=
9k1KoS/view?usp=3Dsharing</a><br></div><div><br></div><div>And the &quot;te=
st&quot; (haven&#39;t updated it yet, because the host is busy with buildin=
g many things ATM).</div><div><br></div><div>#!/usr/bin/env python3<br>=C2=
=A0 =C2=A0<br>import json<br><br>data =3D &#39;&#39;<br>with open(&#39;chec=
ksums.json&#39;, &quot;r&quot;) as f:<br>=C2=A0 =C2=A0 checksums =3D json.l=
oad(f)<br>import time<br>start_time =3D time.time()<br>for (f, cs) in check=
sums:<br>=C2=A0 =C2=A0 if cs:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # 1018.7424070=
835114s<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data +=3D cs<br><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # 1061.4139277935028<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data =
=3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # 1020.9841980934143<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # if &quot;/./&quot; in f:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # =C2=A0 =C2=A0 data =3D data + &quot;./&quot; + f.split(&quot;/=
./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # data =3D data + cs<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 # Test again 2023-02-14<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # took 1076.6172671318054 seconds<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 # d=
ata =3D data + cs<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;/./&quot; in =
f:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + &quot;./&qu=
ot; + f.split(&quot;/./&quot;)[1]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D d=
ata + cs<br><br># =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&quot; in f:<br># =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D &quot;./&quot; <br># =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D f.split(&quot;/./&quot;)[1]=
<br><br># =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&quot; in f:<br># =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D &quot;./&quot; + f.split(&quot;=
/./&quot;)[1]<br># =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D data + cs<br><br># =
=C2=A0 =C2=A0 =C2=A0 data +=3D cs<br><br><br>stop_time =3D time.time()<br>p=
rint(&quot;took %s seconds&quot; % (stop_time - start_time))<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Feb 14, 2023 at 12:15 PM Etienne Cordonnier &lt;<a href=3D"mailto:ecordo=
nnier@snap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi M=
artin, I don&#39;t want to spam the mailing list, but basically you can try=
 to=C2=A0replace this line:<br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + &quot;./&quot; + f.split(&q=
uot;/./&quot;)[1]<br><br>With those lines:<br><br>+ datalist =3D []<br>....=
<br>+=C2=A0 datalist.extend((&quot;./&quot;, f.split(&quot;/./&quot;)[1]))<=
br><pre style=3D"margin-top:0px;border:0px;font-variant-numeric:inherit;fon=
t-variant-east-asian:inherit;font-stretch:inherit;vertical-align:baseline;b=
ox-sizing:inherit;width:auto;max-height:600px;overflow:auto"><code style=3D=
"margin:0px;padding:0px;border:0px;font-style:inherit;font-variant:inherit;=
font-weight:inherit;font-stretch:inherit;line-height:inherit;font-family:in=
herit;vertical-align:baseline;box-sizing:inherit;background-color:transpare=
nt;white-space:inherit">+ datalist =3D <span style=3D"margin:0px;padding:0p=
x;border:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;fo=
nt-stretch:inherit;line-height:inherit;font-family:inherit;font-size:13px;v=
ertical-align:baseline;box-sizing:inherit">&quot;&quot;</span>.join(datalis=
t)

And then you need to append datalist to data.

I think it could be even faster than my patch, but for my test-case this pa=
rt of the code doesn&#39;t seem to be the bottleneck any more anyway, so I =
don&#39;t think I&#39;ll spend more time testing this.</code></pre></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Feb 14, 2023 at 12:04 PM Etienne Cordonnier &lt;<a href=3D"mailto:ecordonni=
er@snap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Note th=
at this is just a cherry-pick from the main branch, so I kept the commit ex=
actly identical.<br><br>However in case your test-case is still slow, I bel=
ieve there is a potential for speed optimization by creating a list and the=
n calling join() one time once the loop is finished (&quot;loop 5&quot; in=
=C2=A0<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sta=
ckoverflow.com_a_75313327_1710392&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0h=
pF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m6=
7E&amp;m=3DHPBNj1QO1qPbzf1RJ4lAV7mnwD4_jzP_YHYEg6vvnJs-ws8Hyh5xTgTYHnjbXlOZ=
&amp;s=3DGdb2DQUOf6peT_9enI2SqvbqHXMOmYziGjtNQHkmPXs&amp;e=3D" target=3D"_b=
lank">https://stackoverflow.com/a/75313327/1710392</a> ). Of course the mem=
ory usage would increase, but it&#39;s a trade-off.</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at =
11:57 AM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" target=
=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr">This might help with:<di=
v><a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzill=
a.yoctoproject.org_show-5Fbug.cgi-3Fid-3D14942&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC=
3JVkLEOc4mUN5&amp;s=3DyeRxgb5569zYnhHWpVFzs4fvU9NrVNah2UOPePY64Rs&amp;e=3D"=
 target=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1494=
2</a><br></div><div><br></div><div>will test it on my testcase with=C2=A038=
0227 paths and update the ticket if this helps.</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023=
 at 11:35 AM ecordonnier via <a href=3D"https://urldefense.proofpoint.com/v=
2/url?u=3Dhttp-3A__lists.openembedded.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJT=
vjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKU=
kSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkL=
EOc4mUN5&amp;s=3DURKYJE0IqTwSkkx42HBRLJE5BsC41VfpRdhus8DX5xY&amp;e=3D" targ=
et=3D"_blank">lists.openembedded.org</a> &lt;ecordonnier=3D<a href=3D"mailt=
o:snap.com@lists.openembedded.org" target=3D"_blank">snap.com@lists.openemb=
edded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.=
com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
<br>
As discussed in <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhtt=
ps-3A__stackoverflow.com_a_4435752_1710392&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJ=
TvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTK=
UkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVk=
LEOc4mUN5&amp;s=3DQpRKrH6Ih3NfErHKEJ3_t6yojMBxhRvk66sn4Gsazkw&amp;e=3D" rel=
=3D"noreferrer" target=3D"_blank">https://stackoverflow.com/a/4435752/17103=
92</a> , CPython<br>
has an optimization for statements in the form &quot;a =3D a + b&quot; or &=
quot;a +=3D b&quot;.<br>
It seems that this line does not get optimized, because it has a form a =3D=
 a + b + c:<br>
data =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
<br>
For that reason, it does a copy of data for each iteration, potentially cop=
ying megabytes<br>
of data for each iteration.<br>
<br>
Changing this line causes SignatureGeneratorBasic::get_taskhash to take 0.0=
6 seconds<br>
instead of 45 seconds on my test setup where SRC_URI points to a big direct=
ory.<br>
<br>
Note that PEP8 recommends explicitely not to use this optimization which is=
 specific to CPython:<br>
&quot;do not rely on CPython=E2=80=99s efficient implementation of in-place=
 string concatenation for statements in the form a +=3D b or a =3D a + b&qu=
ot;<br>
<br>
However, the PEP8 recommended form using &quot;join()&quot; also does not a=
void the copy and takes 45 seconds in my test setup:<br>
data =3D &#39;&#39;.join((data, &quot;./&quot;, f.split(&quot;/./&quot;)[1]=
))<br>
<br>
I have changed the other lines to also use +=3D for consistency only, howev=
er those were in the form a =3D a + b<br>
and were optimized already.<br>
<br>
Co-authored-by: JJ Robertson &lt;<a href=3D"mailto:jrobertson@snap.com" tar=
get=3D"_blank">jrobertson@snap.com</a>&gt;<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/siggen.py | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
index 130b38d8..2381edd2 100644<br>
--- a/lib/bb/siggen.py<br>
+++ b/lib/bb/siggen.py<br>
@@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D self.basehash[tid]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for dep in self.runtaskdeps[tid]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + self.get_unihash=
(dep)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.get_unihash(dep)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (f, cs) in self.file_checksum_values[=
tid]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&=
quot; in f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + cs=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 +=3D &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D cs<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if tid in self.taints:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.taints[tid].startsw=
ith(&quot;nostamp:&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid][8:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid][8:]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h =3D hashlib.sha256(data.encode(&quot;ut=
f-8&quot;)).hexdigest()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskhash[tid] =3D h<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14404): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_14404&a=
mp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z=
-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&amp;s=3DVw-mNHnRPLvPlWEXUYciNNhBB4=
pZanI2ZGEsbWRNR-g&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.openembedded.org/g/bitbake-devel/message/14404</a><br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_96957072_3617156&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Q=
n-XC3JVkLEOc4mUN5&amp;s=3Dl4fkRs6786x3hj5GGhT8XQ30SmRozQ8PJGoP_xPn_y0&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/96957072/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Q=
n-XC3JVkLEOc4mUN5&amp;s=3DDVQKHhGOkYy3oSbWagenl7KtRRYBC1655FauLxtgkHw&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/=
bitbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=
=3D"_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div></div>

--000000000000936c3505f4aa7d1d--

