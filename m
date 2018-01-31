Return-Path: <tobias.hagelborn@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id EB0C7786DD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 13:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2487D1870B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id wLf7BeNByKCD for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id B3DD118708
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FCF21A0BE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 951651A0BD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id 892C022E7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 14:12:35 +0100 (CET)
Received: from [10.94.62.1] (10.0.5.60) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Wed, 31 Jan 2018 14:12:35 +0100
To: <bitbake-devel@lists.openembedded.org>
References: <1517237992-4829-1-git-send-email-tobiasha@axis.com>
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
Message-ID: <9102f27f-e424-4b6a-908b-fa43fb346cb4@axis.com>
Date: Wed, 31 Jan 2018 14:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517237992-4829-1-git-send-email-tobiasha@axis.com>
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] bb.utils.movefiles: Support cross device move into existing directory
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
X-List-Received-Date: Wed, 31 Jan 2018 13:12:37 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 01/29/2018 03:59 PM, Tobias Hagelborn wrote:
> This was a fully reproducable issue with populate_sdk using a setup of:
> * Ubuntu 16 LTS / Linux kernel 4.4
> * Docker 17 / storage-driver: overlay2 (overlayfs) (resulting in cross device copy)
> * Our firmware image
> 
> Tobias Hagelborn (1):
>    utils.py: Support cross device move into existing directory
> 
>   bitbake/lib/bb/utils.py | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Disregard this one. I missed that is is already fixed.

commit e4dae6320506db320d236c6b45f14f15a7c71c17
Author: Mardegan, Alberto <AMardegan@luxoft.com>
Date:   Thu Sep 21 14:33:52 2017 +0000


//Tobias

