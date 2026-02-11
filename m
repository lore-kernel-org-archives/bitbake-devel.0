Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA622E9E2E9
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 11:39:16 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17117.1770809951092110020
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 03:39:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DpVDDQ3W;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb1c4679ebso246288085a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 03:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809950; cv=none;
        d=google.com; s=arc-20240605;
        b=Fy0GkjxWTkV16LfXe0oMsTOh6QQejE/2MEd0yK1tFbsAq8LA+S0ofuIMrzIEFwklFM
         uDY8/VppC0Tl9BhoLqNuAqkhHMz4JkTE8J3IQ23tcfv25sbQ4ErS3EGLYGQtQvMhNDZ6
         uIJPmgi1a9E4ZbsORkBYoQd/sJnrMj6uoaiQUbcVt1LKhXQ9a41khhoXPux/mvyTdOUD
         qSg+dvEzAZMnWPPNHdPeaeH3M6f4G1V8KT8t1ngngqFD+w6ys8K54TA7nZ8WBmFtVCfD
         bfSxpu6D/XgJw+xh2QzSzJlhwwuOIIrZ95alqof1VP2rcqHgBgyxzEUqGXFtql5Go8xd
         3njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fcJTk01ZhAnawvxjHpB/4cijjxqDhlre2KcIE7S/Nn8=;
        fh=C8EP9atbw2RAKBQE/7fJEu7goASmZnntJgPpnTGjy7Q=;
        b=Tdh2vEPkDq9l6217E/zP81oy/gXUUPDZLUMLtgbhuirMGlMNkSJvJ/jilM6zIarCQ3
         LGUNCt0uMsO2CmnLSZkOAdfAR+91Fap+CtExzA+xKhefQ7Ed3x/1S6Ip6ztspuH8vLDV
         ZUbjB4RZPGhVI6oFrq4x6g4iigqo8x0OK4jCfz4S/Q2CLXFfpx5/uRvdI20Z/nM+HBge
         tHlUKFtaUuVhSgGmAW+DTYacDgVw6omPV4/hnnzQDCA84TvL7N310TjrQWM6IsOkKBvj
         tbL0W/X0vAHQfNURWHmEwLRmVy4Eq4uA6FVrKy6tcuHGVqDX02tko6kWX6NObqQ7/9ts
         aCgg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770809950; x=1771414750; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fcJTk01ZhAnawvxjHpB/4cijjxqDhlre2KcIE7S/Nn8=;
        b=DpVDDQ3W2/6g1YxP8lIAGHb9nb/nNGgCXl/8sWlmkQC2479/tmqn7b45p2y7pV2JJ6
         nIqTpNubuRtiorCtm+5JzqTwt93IeuHSRXs6sfD+FqUUmrRtOQopzaj7ykjPgTA+BlWt
         iKr84bzimimQofpdiMzgQ9NLE06zd2YyBqeoUuZabGpUVecclZthVhKUUNO0iWFPDn9r
         CUFPQzSxgF+mPIy/bSZXybIzlhbPh2YNw+xEiJxiLmTgN+xf8X/NaG28gY+Rshbx7a/H
         VeGbZzVUxcBCplW63OcW8lOpEkR0lOVON5dp2JtkrCKPQlBc25eXX/J4JxPWCZLG2EAE
         hArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809950; x=1771414750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcJTk01ZhAnawvxjHpB/4cijjxqDhlre2KcIE7S/Nn8=;
        b=gPgLZ/WB7dy/4aKBJ+D17cNdTQwTlYdnFu7K5li6N6NN8mXLIupQ9wXyZhepGUssOR
         5mIEXW+J73rZgk71gaqgH0W5z8YSysc7ua6dZwEop1b3lgba0uHaLcYhJipQwowjLTJY
         zR8bbu5DvMM4WGcDUtKZcig9Y1fx7HAg1kTQLldJkZ6I+V+enEDu1en31dYFrFMtn956
         E4dEyGdlXU//mpCD2dC3l3LISSJcQ2fzmj7M72rbNVe79uoomvU3mmCP7mbr1mGTJnyh
         SRCT8wcjhanY9TMWs+ZcYAJwiOmulN8i1lciyAWgLaOozFYxqtCa6zVhpqhMCHpH7JLg
         /O8g==
X-Gm-Message-State: AOJu0YzL3WRxU70MBDUfM4oHFQA2iU6npGwzplYOVjXJdefvJ0oHgGoG
	hd/qWHZ55+zHQENs5WVgAbNzLMWk8cj0HwVWztL5mtOwprx85NWu74JIWoemje1uCRuXKJ7tbTv
	MGjdR/N8QLJsz5N6hh5qBkeqau9EVURM=
X-Gm-Gg: AZuq6aKpuVtpA+5swH8cm/pCs/535kl5vXgkbk0Iq0yKYDbCTRESaA4WKgNHKFsWUVK
	mnhEqAReijUX22rrNem8QWbq0LFoRmyL/qdgA39+brtDoHvl8XTkyGvknWqVYeHz1ObfR3OtXR/
	vTPJn5dqAvStG4YjeIM0nq2ZvdXzBajXGkj6qp02mQV+fQ0Uj2fYKSnCTQHE+ZmXlofJxAeemxk
	HuWDhEzgf7isgahe+Y2ljHhmEkPfToXInybChZ+Emh46AUUA+8v1g1fGZQegLiRrbqd4NXn2G2g
	HLnk4htkXXtmEWwiGQRz1mkH/jxVIS9GqiHR1OQPBA==
X-Received: by 2002:a05:620a:4491:b0:8ca:41af:32d6 with SMTP id
 af79cd13be357-8cb1f71365bmr641496385a.70.1770809950061; Wed, 11 Feb 2026
 03:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20260129120421.4413-1-alex.kanavin@gmail.com> <CANPvuR=3_qR3ZFbq_JArT0OjZ67jEh65jPM=zmjx9rktayq6yQ@mail.gmail.com>
In-Reply-To: <CANPvuR=3_qR3ZFbq_JArT0OjZ67jEh65jPM=zmjx9rktayq6yQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Feb 2026 12:38:58 +0100
X-Gm-Features: AZwV_QhWMiXyAPUWh5vlRu9QZeUqi-eCi5Kvs_g4m_6kMnrWCVeVNWWVvv7Uh-8
Message-ID: <CANNYZj9n=Y+S_0_FL3jaALiW1N4pytJ4sDD-_pUu0QqbDeAJ7A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/2] cooker: use BB_HASHSERVE_DB_DIR
 for hash server database location
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 11:39:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19000

On Tue, 10 Feb 2026 at 16:36, Jose Quaresma <quaresma.jose@gmail.com> wrote:
>> +                bb_hashserve_db_dir = self.data.getVar("BB_HASHSERVE_DB_DIR")
>> +                if bb_hashserve_db_dir and utils.is_path_on_nfs(bb_hashserve_db_dir):
>
>
> There is little issue on this, we should check if the bb_hashserve_db_dir exists on the file system first before checking the is_path_on_nfs.
> Because is the user provide a path that does not exist and will be created bellow in os.makedirs it fails with:
>
> stat: cannot read file system information for '/path/to/my/hashserve': No such file or directory

The patch has merged to master, can you make a followup please?

Alex

