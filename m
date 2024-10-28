Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53759D33987
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 14:07:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.52683.1730124414714937905
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 07:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L01g12dv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d8901cb98so3661319f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730124413; x=1730729213; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKKjWeoXOT+S3QYfbLSzJZVg49Jv9e6jg/pbxIgdPLc=;
        b=L01g12dvtqTvVxAjxz8aIQp9GOyKCN2fm2PtUpz+XfGgHEeE2O8Cabskgx+u47dHA/
         UPu8tbsR0pV/L/xZMfYaybPE/niTNgh5g4bQXek42jnlkh3RnE+REAZ54WeObRG7xCW2
         BSnjyy9oXo1PqoQDNFHiFRB/X2vX2YTOezImU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124413; x=1730729213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKKjWeoXOT+S3QYfbLSzJZVg49Jv9e6jg/pbxIgdPLc=;
        b=sWDSuhrEv2fNU46wZSDOYVERG6zd+Xk7snUSXwqLwmmt7kurL/1XBvmgEhilMVCa8j
         h7qhARw0QgTDjRkfdv7iPXWStL16jJ78iDbP5w46QycrHcghUZVE5Y1hzIzdH7fs2hDP
         l62quAwm64Dk6aqHdxYxIDDiAa0PaVFmCg46e2S8CEJKmbA9RhwGGDU6VXGJ8/SgR+Ll
         ME1q6FDO9zHjEuGmMg4gXZ+9irfY5MCYtHWW8/H5K8/1R3otHmG+lXmTBhLtkmtOw0T2
         kM15s4baQ7c26B64nq19vMAm1sBdB7pcmlAjf9JYN4o2dMySq4erl9ZFp8wCgtomvPYW
         SHVw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjfMIeUTPm6oJPQonZxzf0uQqpUqJKEzFHukUjD9AJ1iDrSC9x22tgm2pyJ+8stX2ERFo9tSEaDhtyn3B@lists.openembedded.org
X-Gm-Message-State: AOJu0YykwrU5vnBJciqEQehzGCx5KNsGpxMuS7QB8qjwBYLGg/Spj13Y
	yYL1neMRh4EO60DR5ZbYVN81jc3p8poQlRw7UM8lHXAvNj0fJoTQWdacfSbYNzf9DyT6Yg8Mh9r
	/LRY=
X-Google-Smtp-Source: AGHT+IEFp8t251u4PbV2TdT3C6DA4MOPReos3mo04E6IQQz0dlT2hiJCqSCxZxZlXGoYuKxqNnualA==
X-Received: by 2002:a5d:540d:0:b0:37d:3baa:9f34 with SMTP id ffacd0b85a97d-38060e99a0cmr7772213f8f.1.1730124413097;
        Mon, 28 Oct 2024 07:06:53 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:509d:a248:a274:a307? ([2001:8b0:aba:5f3c:509d:a248:a274:a307])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm9704542f8f.72.2024.10.28.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:06:52 -0700 (PDT)
Message-ID: <d122bfdf0fc1684d7aea91f3020e2037cb95356a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/5] gitsm: Remove downloads/tmpdir when
 failed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Cc: Steve Sakoman <steve@sakoman.com>
Date: Mon, 28 Oct 2024 14:06:50 +0000
In-Reply-To: <c4e94db7e266f90dde06cd7d0e73dd3b035e121f.1729933869.git.liezhi.yang@windriver.com>
References: <cover.1729933869.git.liezhi.yang@windriver.com>
	 <c4e94db7e266f90dde06cd7d0e73dd3b035e121f.1729933869.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 14:07:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16737

On Sat, 2024-10-26 at 02:39 -0700, Robert Yang via
lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> The tmpdir such as downloads/tmplp3cnemv won't be removed without
> this fix.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

Thanks, I've been meaning to track down the cause of those!

Steve: We might want to consider this to help the autobuilder.

Cheers,

Richard

