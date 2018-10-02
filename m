Return-Path: <fw@javox-solutions.com>
X-Greylist: delayed 883 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 02 Oct 2018 16:39:27 UTC
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.27])
	by mail.openembedded.org (Postfix) with ESMTP id 606F87943C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2018 16:39:27 +0000 (UTC)
Received: from [89.0.32.146] (helo=[192.168.178.95])
	by smtprelay04.ispgateway.de with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
	(envelope-from <fw@javox-solutions.com>)
	id 1g7NTX-0003AT-K6; Tue, 02 Oct 2018 18:24:43 +0200
To: bitbake-devel@lists.openembedded.org
From: Florian Wickert <fw@javox-solutions.com>
Organization: Javox Solutions GmbH
Message-ID: <fa53fd11-b621-63ae-a1a6-bf2a4803a796@javox-solutions.com>
Date: Tue, 2 Oct 2018 18:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.0
MIME-Version: 1.0
X-Df-Sender: ZndAamF2b3gtc29sdXRpb25zLmNvbQ==
Subject: gitsm fetcher does not work anymore
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
X-List-Received-Date: Tue, 02 Oct 2018 16:39:27 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large

Hi all,

relative URL schemes (e.g. submodules in 
https://github.com/xiph/Icecast-libshout) or SSH URLs (e.g. 
git@github.com:user/example.git) are not parsed correctly since the 
rework done in 5cd00e3e53819f3c10d1733480077ce9f3cc2ca8.
The SSH scheme is required for private repos on github because https 
doesn't work with SSH keys.

Regards,
Florian

-- 
Florian Wickert, M.Sc.
Javox Solutions GmbH
Gallierstr. 33, 52074 Aachen
Germany

Phone: +49 241 99034569
Web:www.javox-solutions.com


