Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jpuhlman@mvista.com>) id 1S8anI-0002Wz-30
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 18:18:24 +0100
Received: by yhjj56 with SMTP id j56so4529704yhj.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Mar 2012 10:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:x-enigmail-version:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=RIjVfCU6phsZO35DkgF2YPqb74NP/xFX5EZTNzWqiUM=;
	b=RAT+AadL8ywpgmfeITR5s+BUSgAi50AdzW0LfuwveyE77Udiyjh4haSDLtXpb29j39
	OvlIOXl9utUm2xKLMZ/1729QSjyIahK1ElO6b1eoF62XULeokX5r4meYQpfr6NE1xPBd
	wwodEzb16YzRnn/VlZpwU72SdkeDcgKreWj5yJDzDSJx5aBCPymIvZKra9TGBqTSvpar
	XGO28zLmd9mFHRuy6jhlkvQ/1zFiMQb7pGnABTh3X4Iok30bMrnArzj1NQoN8KBcRvg9
	aJKK9BHOqXHP/0NI3KXtzktvh3TZWbkSSj0MsEa9BYbqnjaJDFderXf2ZUTlcC2G6u8g
	ZKrQ==
Received: by 10.68.216.132 with SMTP id oq4mr16743598pbc.41.1331917775149;
	Fri, 16 Mar 2012 10:09:35 -0700 (PDT)
Received: from [192.168.1.4] (c-76-20-107-156.hsd1.ca.comcast.net.
	[76.20.107.156])
	by mx.google.com with ESMTPS id j3sm4686119pbb.29.2012.03.16.10.09.33
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Mar 2012 10:09:33 -0700 (PDT)
Message-ID: <4F6373BE.3040209@mvista.com>
Date: Fri, 16 Mar 2012 10:09:18 -0700
From: Jeremy Puhlman <jpuhlman@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQkMsihWjz2B+nbz0Y3fsbxdoEXLpK3cU2o2zCjeMCHqhhIAMvXp9ycoyo99jfhO1ArPxvrx
Subject: Conflict between BBCLASSEXTEND and named recipes.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Mar 2012 17:18:24 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

There seems to be a bug with available providers when a recipe file
provides the same name as an extended recipe. The extended version of
the recipe does not seem to be available at all.

Example:

If zlib_1.2.6.bb exists in a layer, with BBCLASSEXTEND="native
zlib-nativesdk" defined, and zlib-native_1.2.5.bb exists, the version
1.2.6 of zlib-native is not selectable at all.


bitbake -s | grep zlib
zlib                                                :1.2.6-r0
zlib-native                                         :1.2.5-r0
zlib-nativesdk                                      :1.2.6-r0

Even with PREFERRED_PROVIDER_zlib-naitve = 1.2.6 the results are the
same. I have been poking around the parser, but really haven't made any
progress, figured I would poke the list.


-- 
Jeremy Puhlman
Montavista Software, LLC.


