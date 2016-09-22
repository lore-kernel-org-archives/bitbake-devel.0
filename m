Return-Path: <pascal.bach@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id 8AE8960616
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 07:45:29 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id u8M7jTKq021315
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Thu, 22 Sep 2016 09:45:29 +0200
Received: from [139.16.76.169] (MD1FZU9C.ww002.siemens.net [139.16.76.169])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTPS id u8M7jTBl030986
	(version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Sep 2016 09:45:29 +0200
To: Christopher Larson <clarson@kergoth.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
	<CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
	<508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
	<CABcZANn4D8Qog6ukM_7XM65ZY+OymnmD2K8DeipxoVOOaY1FcA@mail.gmail.com>
	<64d81891-801e-292e-e26c-1c44bd38a8c5@siemens.com>
From: Pascal Bach <pascal.bach@siemens.com>
Message-ID: <02946d54-8e3d-78ce-a094-e06365273cf3@siemens.com>
Date: Thu, 22 Sep 2016 09:45:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <64d81891-801e-292e-e26c-1c44bd38a8c5@siemens.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Thu, 22 Sep 2016 07:45:31 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


>>     The tarball should only be fetched if the local ud.clonedir is out of date, this means the revision that is requested via SRCREV is not in the local repository.
>>     In the case the revision is present the tarball should not be fetched again, at least that was the intention and my local tests didn't indicate otherwise.
>>
>>
>> Yes, but it’s better to run ‘git fetch’ in an out of date clone than to re-download a 1gb mirror tarball which may well be out of date too.
> Agreed, but this doesn't work in the case where the machine doesn't have access to the upstream git repository. For example in the case where BB_ALLOWED_NETWORKS = "*.my.company". The fetcher would still got to to github.com which is not allowed, in that case it should fall back to fetch the tarball from "mirror.my.company".
>
> I'm open for suggestions how to make this more efficient.
Does anyone have a suggestion how this should behave in the ideal case? In my opinion if there is an internal mirror defined it should always have precedence even if it might be less efficient.

Pascal


