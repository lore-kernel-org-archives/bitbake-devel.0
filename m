Return-Path: <sledz@dresearch-fe.de>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id CE3CB60167
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 10:54:57 +0000 (UTC)
Received: by wibxm9 with SMTP id xm9so17282601wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Aug 2015 03:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-type
	:content-transfer-encoding;
	bh=C4BtatqN/ROX/E9yaA9+GsOhPmQt5gX7sd0kcZ8FpXs=;
	b=R13TTY97Dko8/eDGleJXEeSradrXNvXzgQHaf0DoAxFrlrxeLdYOwSqqTWtwjiIkgf
	jwwsxKaUup9uFQ4homZwbHVge1iMWOWvfuB+5/PYsEwUZmWE6+oZuF18lS/R23/p+L8Q
	m2tsGxvRlUWD4iBw++VPn9gVDgL88iAbdN/MW88ZphFNV/6VJ2Ny+vhv68Va5cGGOftx
	D1FI5uQkPJVKWPLyJ3dCkjXNiez30VnJgzRyernJFzPiUxmxA2RpMO5hjs7nKv7+0knl
	NaVuEa2DzUruXaMgklQ3B4Bk+br58isuDx3Petn39K0ptU1X5QoXkmUIeNPt1PCJw8qH
	+gMQ==
X-Gm-Message-State: ALoCoQlzQtj4qrHumEpwQJMxhszEM8B/xBBuKEvE/STIirm3MmPmZY8LtfrZnbIpBs1oeM/HIrTm
X-Received: by 10.180.98.134 with SMTP id ei6mr4859213wib.49.1438858497619;
	Thu, 06 Aug 2015 03:54:57 -0700 (PDT)
Received: from [172.29.23.46] (zk223.dresearch-fe.de. [217.92.177.116])
	by smtp.googlemail.com with ESMTPSA id
	x6sm2673997wiy.6.2015.08.06.03.54.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Aug 2015 03:54:56 -0700 (PDT)
To: openembedded-devel@lists.openembedded.org,
	Ash Charles <ashcharles@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	danismostlikely@gmail.com
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
	<5567C5B1.7010901@windriver.com>
	<CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
	<CA+chaQe_T9zPjckAm+NZrZpdw5BO81eL-vxrAA-2kYymMRbd1w@mail.gmail.com>
	<CAK8F28=cu6z2m3hNGkO-qkzDhyfuZwPG-Q-n+2rY95NvmwuStg@mail.gmail.com>
	<556D3337.7020905@windriver.com>
From: Steffen Sledz <sledz@dresearch-fe.de>
Message-ID: <55C33CFF.3070200@dresearch-fe.de>
Date: Thu, 6 Aug 2015 12:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <556D3337.7020905@windriver.com>
X-Mailman-Approved-At: Thu, 06 Aug 2015 20:38:30 +0000
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Aug 2015 10:54:59 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 02.06.2015 06:38, Robert Yang wrote:
> I'm working on fixing the issues now, will send patches sooner.

Any news on that?

-- 
DResearch Fahrzeugelektronik GmbH
Otto-Schmirgal-Str. 3, 10319 Berlin, Germany
Tel: +49 30 515932-237 mailto:sledz@dresearch-fe.de
Fax: +49 30 515932-299
Geschäftsführer: Dr. Michael Weber, Werner Mögle;
Amtsgericht Berlin Charlottenburg; HRB 130120 B;
Ust.-IDNr. DE273952058

