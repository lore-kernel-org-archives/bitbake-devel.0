Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E18C282DE
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 17:57:25 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.311.1741197443339649447
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 09:57:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MxkbER6y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so14277845e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741197442; x=1741802242; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+r4jRkChY0XUOaUHyDTng//MPNw5LkcS5Z8C8N4QDs=;
        b=MxkbER6y7816FWzVu0wFgcHbjF7g6Il9OiQlgxCTjZTf/1VxpN69wSe2RRHKYIQZkr
         6EmITCWL7eQZ+S3GJ42zhM8aKSbR//CrufN0X5jqOhtz1B4H+Kxi9FY7Wc2B/Og6Nh1f
         JINNxBb6gPA3rvOjtmYSN8YafHLlQQA1wZUP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197442; x=1741802242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+r4jRkChY0XUOaUHyDTng//MPNw5LkcS5Z8C8N4QDs=;
        b=e12NkIYMFkC050xbo0AdODjXZxsIzsgtXRgigU32UTWdZ81iigY3ZuNF9CGEXNnOWQ
         0BB8k0VKAb6/rWWU/39FoY2OSn6r/pzHBF4pvZEA+zIJ9xSGsjT2V58rpSrmEpimK0pN
         uYsjyQSkU1GB23S4N7vrfWf2maO6XsZ79e6luWFVEnAVShvEl4108VhCQp0GbNjGSLQn
         R67ntF+8mPzK2DAGJ9cMfoKnXay1QaZN2gb7GhMuE/OHt/nHQgHItOFsMkEK6rqkOqej
         Rw8L3Q/mPYt8Uuenmklno4726OjuEpZrzz58nXZEBo6+a4sNjWSYRbyfa2kopDYz5OMW
         VuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUswoPA5O3cWsKDMf9VPMEvziuOkswPVqRwKaYNKJmGZuCSoQjweiHfp/b6HDkLH7aEjCPDrCQLrNpX+6It@lists.openembedded.org
X-Gm-Message-State: AOJu0YxWtW33ads/fZYYMbhd3bJn/L+osyhVjrTlMp7EvDPmGnOfjKHY
	iahSok/gBlSkHirPMe/XzVirLU7xm9D55MuehzNFov0o68KuB0NGtkoMk5nAidfLJQ2mfnFlfVo
	Y
X-Gm-Gg: ASbGncuY28dDTNf05ZmcQEAPacabDcjdz9oUyB6WHA/9e4sd0YvEDtjaJjBkPFApqZV
	A0qwTBY1Y2aKinFEg3fy37xfogQQS7gm16nt7boktSV4WRtJ8EH9dv0QcTqN+37TBQwruuSzLc5
	zrZXEtJuOqFkYvya3j300GnEVFCwVUJD2PoGD3S5S1DfMwozg/9hZGEp6t43HLzSR9WiFWbt3Hu
	F0OeMwX2rwZFGExlnXNcDohFVB0rRrwqIo49VJfJgqhW0URCuEX9LN1v9+uaFnITWLZrEfv2R3J
	TT02Qq6Xjnos0jT/lpgiH3eDpU9Yb8XilB4JZXUFptX9pD7ONj985dMHiVQ+XBNsy+dhHzAPURK
	Pq0cwf52Tg9e+jrRqHhoGGZp6vZ5LqTPO4w==
X-Google-Smtp-Source: AGHT+IEZbdetyQkmiAQAQ1o2dwtC+XAnW3a+Qs1TLyegjQ8bQ5cHi31m/GjFh3OBUkKUDa7/sNXfNg==
X-Received: by 2002:a05:6000:1f85:b0:390:f698:48cf with SMTP id ffacd0b85a97d-3911f7202e3mr3311388f8f.2.1741197441548;
        Wed, 05 Mar 2025 09:57:21 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:939e:c44d:2366:e8da? ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dbe7sm21929874f8f.93.2025.03.05.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:57:20 -0800 (PST)
Message-ID: <b48269da6ca20f9bc37ec39e7e35d2a43380df61.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 4/4] data_smart.py: clear expand_cache in
 _setvar_update_overridevars
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Date: Wed, 05 Mar 2025 17:57:19 +0000
In-Reply-To: <ff241013-6c0c-43e7-8e18-455eb5e026d4@windriver.com>
References: <20250225064853.2406575-1-Qi.Chen@windriver.com>
	 <20250225064853.2406575-4-Qi.Chen@windriver.com>
	 <ff241013-6c0c-43e7-8e18-455eb5e026d4@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 17:57:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17386

On Wed, 2025-03-05 at 09:57 +0800, Chen Qi via lists.openembedded.org wrote=
:
> kindly ping

Sorry, very briefly, 4/4 looks right, I merged 2/4, 3/4 removes a
cookie monster reference which needs to stay somehow. I need to double
check the rest of 3/4 but it probably is right after we switched
override characters. 1/4 is probably fine if all the tests pass.

Cheers,

Richard

