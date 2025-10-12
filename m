Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8CCCD187
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 18:02:33 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.23637.1760292149984443374
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 11:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AXe56SJV;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-799572d92b0so45240636d6.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292149; x=1760896949; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1hKTsFjnk3AM7NkJQY5GmdSCHYyXAf7lbvdJDULIso=;
        b=AXe56SJVrN+fk3QsA00pZ4vO78whVtMdu/oP0hlVDYyNlYcX+DoM7wZAoY3/FDSq/U
         yXsoy30VRCb5+TmKcPVPMwXGHN/fT8OcvXKTJ+wv/EOsv4Mj1jL9FQJe7/VKBSgbw85u
         9X9pg0yIyIcR/8afQ3/clUWD+aXtOAffNAt+OrLsl9YVLTqOGHouAvj6UEA9KAVu4vHT
         nSbHS+W9Vj9+tVWAmojn5irrDN6iuPD2F1NkHhwcsQVaq/UQKaOgbMxd+SePLbcbeltY
         9va/IxFP5LOo5hIAlE8I0QSUR6zXcsbf1F8hmE+W3juFb7NA9JQfDwY+YDqJ9UEyPlBz
         E9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292149; x=1760896949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1hKTsFjnk3AM7NkJQY5GmdSCHYyXAf7lbvdJDULIso=;
        b=klW8G53OerwQxnvh1yQnjLQ7iWqa5pBQOIrsZfnWR7qt5u+vfIRVzjw0f24NQ0W38F
         7fIMtDW8d4i4L408ifIGd91Pfs5bzpp1uQuSNmAJ2eGPbFG8o9ko7A9UY77WunaFGkMN
         tE2udzCDV7M0wDkCMvHHszGggxwrIC0XmZfkGvaqKgBo7jFpN3g3Va3YTzY7jWxHh+eW
         i4LSzQVcKuGxtBlezI8mxZ6xJOqt0hLb8GdmA/UfeY8SDHiN/GSlu4GGxiMjE+boNILf
         mou4pGP1QwJTFFQr3ytnK55RnqW9DDDCrRI4v1z/iJ6hSHgXLUjj3IWbMTNRJvc2/vlU
         Eo8A==
X-Gm-Message-State: AOJu0YwReDJ92r2gsTg5ITXYm8QaL+JZORbGP11r2Urskz9acGroAs8c
	HkDTLzLdqZOP7kZ/77P+3UzR0iG6oFyaOyDNRn6IPz00mbRuFh/YiYLaJEZzNs78vu150axvAqH
	/6TaQ9NIsAlzwIUmUzlHnSnOwhP3u3P4k3gAln8Y=
X-Gm-Gg: ASbGnctP3cyv+MDHls79bf6rmvmFDN44HQ8J9z+S1IKS3GS5qfcm/qYZ/7+ZtK8bqBE
	jCoQOxWOFlHRNILUIOvXjlRVvHCodON1svJW8oOnenBAg6v/vRULiFUPhtVMciPjAQLu+S97iDz
	bRbyFhDrsZd4yB7vRMrdJDzNfRkt4NVs8uKv1pV/71dfgDpk13nwfhoihSkW1nYa2yNKfSGgWA+
	IaSc2YR3a9Jluy10+WvDNQB98IhJHNcDMja2pe11MdVAZJDkM2z5QUfZ+xteCG9E7gu83EICJlk
	YDWnEvzvH5LP2n5WyifOTR9HK2kOqgQhNklo
X-Google-Smtp-Source: AGHT+IHmp4Ee2gaugGZAIdIXwZ4SVdTWe9YBNB29DBuIpBHaj/WE6Io+ocHTxKYT732Jo2lTZBx7BtpvqO9OWBBoJiw=
X-Received: by 2002:a05:6214:5083:b0:783:cc80:1770 with SMTP id
 6a1803df08f44-87b2106d967mr278370526d6.25.1760292148889; Sun, 12 Oct 2025
 11:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251012174727.4191604-1-alex.kanavin@gmail.com> <186DCF96641E42F9.9110@lists.openembedded.org>
In-Reply-To: <186DCF96641E42F9.9110@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 12 Oct 2025 20:02:18 +0200
X-Gm-Features: AS18NWD10uRQktsPmvzuhfl4qPqkZplDkNWtijVr8yGDFggBNSpbv9Fv8ReHDA0
Message-ID: <CANNYZj95DHnABGNM_2ykAWn3+9kJxxDpWzPgWHqbOMokAVWQbg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 5/5] bitbake-setup: commandline: use
 subsubparser for settings {list,set,unset}
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 18:02:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18180

On Sun, 12 Oct 2025 at 19:47, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> The new help text now reads:
> usage: bitbake-setup settings [-h] [--global] {list,set,unset} ...
>
> and the respective sub commands:
> usage: bitbake-setup settings list [-h] [--global]
> usage: bitbake-setup settings set [-h] [--global] <section> <setting> <value>
> usage: bitbake-setup settings unset [-h] [--global] <section> <setting>

A note from me: I'm well aware this changes the settings UI yet again,
at the 11th hour, and I'm feeling slightly uneasy sending it, but I
still think it's a worthy improvement:

- currently bitbake-setup tries to mimic older versions of 'git
config' UI. But those older versions offer a confusing, convoluted
mess, and shouldn't be imitated. This change adds a nice bit of
structure and clarity to the operations, and follows what recently
released versions of 'git config' do [1].

- the principle of reading global/local/commandline levels of settings
and not creating them unless asked to and all other existing
functionality is retained

- the needed tweak is basically inserting 'set' into places where a
setting is set, so it's a small one

- something like this should be done now, otherwise we're stuck with a
sub-optimal UI.

[1] https://git-scm.com/docs/git-config (see also 'deprecated modes'
section for the obsoleted UI)

Alex

