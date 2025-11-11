Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF7CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 21:44:26 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1213.1762897456372658448
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 13:44:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DvJr4jay;
 spf=pass (domain: gmail.com, ip: 74.125.224.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640d43060d2so204980d50.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762897455; x=1763502255; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfmHC6Ufg4+dckCnH86ynDGBjFMw7BqCjpEheMnCYO4=;
        b=DvJr4jayhhr2EX9sskXwwNnGF5oy0F2dkCjdNpA3c9MBpXRWWFv+vS1EvmO2oGR9N8
         xADQk4hfVFZKxfCHqhu1m/FYvEPGf4fPUHmyPGTcuN2yCAYIzT5mYvrUItzOqcbXviPe
         5dTT4AekiCmrs+cG4/iL9zz3gdD+ThQow+q4FAgZ75XBRupC79gQLB2TeCS5Pfi6BpZp
         XH32JXyc7dEsXqHA/ouHN4y/wSyOH/oiUSWfMUF1vuovlkvYCdzSiyiwMWjVx7xpBgo/
         w0k55LqPW+c0627ygt6jZdH2hhRfwrdPC38afwF3u9oURfft8oAh8KXrnw9YzJjGtqzv
         kJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897455; x=1763502255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfmHC6Ufg4+dckCnH86ynDGBjFMw7BqCjpEheMnCYO4=;
        b=nBHlghVrSHV0Qu7fE+ZPiDmOAqvWOYEjS3qnhHGfsfll0afj7+EkN6LgSt/N+0UtmS
         ZLQb6y7sVRe6A/rKB8kg/ECATYZzpurywQ32nrERpON9UOPSt50Zz2X3biE3bk+ywXxp
         S3UpgJXHTwCkUO+RscK4PbvLsvobCGz2hr/ZVJ7zQpJhRTMwMAfsSR/4LKRF/35GZr0l
         VeeCssB7oeMBsbdLZqGJuW97R8MscSkdt+sFx31vBBj7HhP+IdrV1naodLPyLs7pnaCU
         tZ5kxeaqj36PJu6ZYWuk02Ho/HYBQyzKuFfd1yKgXGpjd08T6MnzIB8ovePW6tabtIaE
         elbw==
X-Gm-Message-State: AOJu0YwSyp6mwApWUHwNm/gZRNpM4tF40O0iRJms5VBkTniGpJVET9hh
	G5yMRRMTDaHkAjOXtdmh9QNpBJDvrAXajJ1Zv3EBJgBUgsKxNbrr0NsOUh7VHTZk1mOGI30gaJD
	hLJqNPqUHdmoLqzQJEtpsrAAW9Dgti1ygrQ==
X-Gm-Gg: ASbGnctgdrppnHAOBs4Ib0H5yHbNoKXkfOSo4CBzOv4EPQJAc5lduCQycuZY3bCxFCw
	UGG5xb5DJHROTQPZa+P0zsJrWsV01hpu6lwRQCZ+cYQPRTsSrmQ8oPbSQ6Hz2R8Nw7O1Su+ou2U
	BRouxSL56dACe+CbCSDAuGUeS6A0MKr/lY4SKdKwkvio32xvqAkzfAvaclNZ53kvItexBvEYszn
	OEvMPOCSeEqJa8/M1NyZln5kHeuIRl6tFVmRNB+N9Osvyhvbln8vg2Ij5j+dfrKX5WKVGVYjl5N
	N0eYP7oKNTlIn59kPCD/
X-Google-Smtp-Source: AGHT+IFIhkOIcxyW+DCq0A+i5h0ZWFC5muhn/eoQFwXxGrlUyVWJv7+tKgqJtFty8bbtER+gjse1b4FQLaRoepBHNdI=
X-Received: by 2002:a05:690e:4352:b0:640:d9b1:ecf7 with SMTP id
 956f58d0204a3-64101a562a1mr760213d50.1.1762897455346; Tue, 11 Nov 2025
 13:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20251111173841.2842051-1-JPEWhacker@gmail.com> <CAMSfU+7iftgMgVfkC0KwV2JTQpi-aR9+RXKcoxQ_mZ4mMM0xMA@mail.gmail.com>
In-Reply-To: <CAMSfU+7iftgMgVfkC0KwV2JTQpi-aR9+RXKcoxQ_mZ4mMM0xMA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 11 Nov 2025 14:44:04 -0700
X-Gm-Features: AWmQ_bnZX0Wc-iYwNL0cFvQMSFCSpVnqv5eYNzdjn21Cjzsgh3wtPRUcCy9LMl0
Message-ID: <CAJdd5GZc0q+Vg1f1Wu-5C0ixSMCO6YHRGeJDbKZi6WCvcsHB5w@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] bitbake-setup: Improve continue prompt
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 21:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18336

On Tue, Nov 11, 2025 at 2:18=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> Hello,
>
> Le mar. 11 nov. 2025 =C3=A0 18:38, Joshua Watt via lists.openembedded.org=
 <JPEWhacker=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :
>>
>> Reworks the prompt to continue with the setup wizard in a number of
>> ways:
>>  1) Default to 'Y' if the user just hits enter. In general, users are
>>     more likely to want to continue than they want to exit.
>
>
> In the absence of Alex, I'd like to remind what he said about defaulting =
to No: https://lists.openembedded.org/g/bitbake-devel/message/18113:
>>
>> There was some discussion as to whether this should be Y/n (e.g. hit
>> Enter to proceed). I'd rather err on the cautious side here, as people
>> nowadays have muscle memory to agree and accept with anything and
>> everything, and proceed as quickly as possible, they would do it here
>> too, without reading what the tool is going to do, and only then
>> realize it's not what they wanted.
>
>
> Personally, I'm slightly in favor of defaulting to Yes: This will make th=
e experience more fluid for new users and answering Y instead of N is not t=
hat dangerous for bitbake-setup (IIRC, we're not erasing any data just putt=
ing files in an unexpected directory)

That's fine. If we don't want to merge this I'm not going to argue.

>
>>
>>  2) The tools prints "Exiting" when the user doesn't want to continue,
>>     as a clear indication that the script exited without doing anything.
>>
>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>> ---
>>  bin/bitbake-setup | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
>> index 282fa82ff..9c6d787bf 100755
>> --- a/bin/bitbake-setup
>> +++ b/bin/bitbake-setup
>> @@ -134,6 +134,14 @@ def checkout_layers(layers, layerdir, d):
>>
>>      return layers_fixed_revisions
>>
>> +def prompt_continue(non_interactive):
>> +    if not non_interactive:
>> +        p =3D input('Continue? (Y/n): ')
>> +        if p and p.lower() !=3D 'y':
>> +            print("Exiting")
>> +            exit()
>> +        print()
>> +
>>  def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
>>      def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
>>          os.makedirs(build_conf_dir)
>> @@ -483,11 +491,7 @@ def init_config(top_dir, settings, args, d):
>>          return
>>
>>      print("Initializing a setup directory in\n    {}".format(setupdir))
>> -    if not args.non_interactive:
>> -        y_or_n =3D input('Continue? (y/N): ')
>> -        if y_or_n !=3D 'y':
>> -            exit()
>> -        print()
>> +    prompt_continue(args.non_interactive)
>>
>>      os.makedirs(setupdir, exist_ok=3DTrue)
>>
>> @@ -676,10 +680,7 @@ def create_siteconf(top_dir, non_interactive=3DTrue=
):
>>          print('A site.conf file already exists. Please remove it if you=
 would like to replace it with a default one')
>>      else:
>>          print('A common site.conf file will be created, please edit or =
replace before running builds\n    {}\n'.format(siteconfpath))
>> -        if not non_interactive:
>> -            y_or_n =3D input('Proceed? (y/N): ')
>> -            if y_or_n !=3D 'y':
>> -                exit()
>> +        prompt_continue(non_interactive)
>>
>>          os.makedirs(os.path.dirname(top_dir), exist_ok=3DTrue)
>>          with open(siteconfpath, 'w') as siteconffile:
>> --
>> 2.51.1
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#18332): https://lists.openembedded.org/g/bitbake-dev=
el/message/18332
>> Mute This Topic: https://lists.openembedded.org/mt/116242231/4316185
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [yoann=
.congal@smile.fr]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>
>
> --
> Yoann Congal
> Smile ECS

