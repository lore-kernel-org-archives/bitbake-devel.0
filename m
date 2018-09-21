Return-Path: <prvs=795b04f21=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 610 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 21 Sep 2018 07:12:34 UTC
Received: from esa3.bmw.c3s2.iphmx.com (esa3.bmw.c3s2.iphmx.com
	[68.232.133.150])
	by mail.openembedded.org (Postfix) with ESMTP id 1B593744DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1537513958; x=1569049958;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=zZ8Uc/7R055mzl7/8skCxNIDRRx+0PANpvNuQGZEhMg=;
	b=H3tDh+evVDLZywFt47RUwR6f48ub2dNyPsAs+fjIr9aJ0IW61X0ZOp8S
	hSnx3W2MO1oJPm41xaOkKPgghAg5FmN0W61gryaYTNAg7ctJlpLw/N6MJ
	ELibzVJQWsCd4lQZ3XbPsA8ZF+iftjjI8NVVTdai4xczLrxLyZhfkVVq1 0=;
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
	esa3.bmw.c3s2.iphmx.com with ESMTP/TLS; 21 Sep 2018 09:02:23 +0200
Received: from esabb5.muc ([160.50.100.47])  by esagw2.muc with ESMTP/TLS;
	21 Sep 2018 09:02:21 +0200
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp)
	([160.48.96.46])
	by esabb5.muc with ESMTP/TLS; 21 Sep 2018 09:02:21 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10j.europe.bmw.corp
	(160.48.96.46) with Microsoft SMTP Server (TLS;
	Fri, 21 Sep 2018 09:02:20 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1367.000;
	Fri, 21 Sep 2018 09:02:20 +0200
From: <Mikko.Rapeli@bmw.de>
To: <mark.hatle@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH] Fix gitsm networking and mirroring
Thread-Index: AQHUUUDB8lJjVlJRBUW02oKX8oNt7KT6LgsA
Date: Fri, 21 Sep 2018 07:02:20 +0000
Message-ID: <20180921070220.GR9430@hiutale>
References: <20180921001815.18248-1-mark.hatle@windriver.com>
In-Reply-To: <20180921001815.18248-1-mark.hatle@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.37]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix gitsm networking and mirroring
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
X-List-Received-Date: Fri, 21 Sep 2018 07:12:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D441087E841A5742A451393EF063A31B@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Looks good from what I understand of the patch, but I have a question about
git/gitsm fetchers:

Is it possible that two recipes end up modifying the same file e.g. via
hard links when they use git submodules and share one of the repositories?

I'm seeing very odd build failures on sumo and it looks like
recipes are either mixing up files in their sysroots or seeing each others
patches on top of the shared git submodule tree. These happen when building
the whole system and rebuilding affected recipes alone makes the problem
go away.

With svn fetcher we see the same, but that's one of the problems we knew ab=
out
from past. svn fetcher does not lock the download cached tree correctly
and if multiple recipes use the same repo, one of them can see the repo
in an inconsistent state and fail with various errors. Our workaround
is to switch to http/s fetcher instead.

-Mikko=

