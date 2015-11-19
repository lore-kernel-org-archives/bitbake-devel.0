Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 96B036010B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 12:41:16 +0000 (UTC)
Received: by wmww144 with SMTP id w144so114727426wmw.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 04:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=fxg6ZM/XrctVUaGaKIytCmza/MXuoamDNxWB0D0Z8hY=;
	b=BgOwLkF8XILVI8uqsHcnEqQUT4NLjM0NbsxwPMAZQOH31ZjfKDQzStIM8LkV5Gwy0f
	cDwQucr60CWpWbrMb2pccZDhZd4xr4Qcm/9YZK8NkVvAEPRAO3JsSMdGPV/Ufbq13ipO
	F4AiLMN0O3HF7G3EVVVYujwMz6b1UqU/imGx1P/+3HdBjr1sENz/JOUEa5sVwwPJ8fqm
	slb7GgUY29KQglpN1FPSfeQidjsO+fW0+RSqZHFEtjs6e779h2I/vW8wIryVwDII6HqB
	tHMwn+PAr1wdb51L1ipIHZxFs8odXlCRO4x5EY/Tb92JsPUd0eL1rGOiJXFmfa0RUVN/
	lQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-type:content-transfer-encoding;
	bh=fxg6ZM/XrctVUaGaKIytCmza/MXuoamDNxWB0D0Z8hY=;
	b=JfIJsaYNKHmFM8oxhaj0WFG/YBKpkOcuENAhtnO29o9ji7AEDaPOWtjuFH9s1I+fYf
	QusrrqgHy9sjMCEuEQIUugKBBhQQMYZZxapl6bGJpaC0rZI9Co9AVxYyo49fsiDXg8aq
	M1RpD3jWexgGO3m4zw5Ta1oN/5mW1rlPRkn+TieKDGTaBW/lwB6/yJ+uukvelN/Tep0O
	C5bzTZ57bUChYXJOMmIAq+g1Lo+09Ls4nWYcezpZqUwMCuz3oF5kSMx8ZwarTsBy0+y8
	jfdNKeMueHOnSY01ZJonQKeI4yvSdYDyoAvwRNUuplT1n8L5yXA6jhU2mc3eJNXcVYWR
	46mQ==
X-Gm-Message-State: ALoCoQlAsNvDttwmVQTdC7L3CFG14NGiuEMF844cvdM+6uu9zGy+JZ1ZKjEsn41zcqI5gp3E5EcL
X-Received: by 10.194.110.35 with SMTP id hx3mr9486267wjb.0.1447936876793;
	Thu, 19 Nov 2015 04:41:16 -0800 (PST)
Received: from [192.168.2.10] ([83.217.123.106])
	by smtp.googlemail.com with ESMTPSA id
	h7sm7757275wjz.7.2015.11.19.04.41.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 19 Nov 2015 04:41:15 -0800 (PST)
To: bitbake-devel@lists.openembedded.org
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <564DC36B.3030900@intel.com>
Date: Thu, 19 Nov 2015 12:41:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
Subject: Release and versions
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
X-List-Received-Date: Thu, 19 Nov 2015 12:41:18 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We're currently manually maintaining a file[1] that maps metadata 
release names e.g. 'fido' to the corresponding Bitbake version in 
'toasterconf'. This is time consuming and confusing for people who are 
running Bitbake/Toaster or Poky to work out which toasterconf is suited 
for their setup.

Currently the only real need for these files is to know which Bitbake 
versions are supported with which metadata versions, without someone 
reading https://wiki.yoctoproject.org/wiki/Releases and editing a file 
and submitting it. Would it make sense to make Bitbake versions match 
those of it's metadata?
If departing from the current numbering scheme wouldn't be welcomed, 
would there be room for a compromise where the Bitbake versions also 
contain the release name e.g. 1.26_fido?

Thanks,

Michael

[1] 
http://cgit.openembedded.org/openembedded-core/tree/meta/conf/toasterconf.json





