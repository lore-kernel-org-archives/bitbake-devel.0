Return-Path: <twoerner@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 7461772CC9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:17 +0000 (UTC)
Received: by mail-ig0-f173.google.com with SMTP id a13so23848472igq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=gEoEHM6ktJKbaYGQubxaBuN/y3rBIaeX6OCQ+vIhq3U=;
	b=qxvJMkhQvZb6mNxHxZVwOCpT8shsUYicl8ktCYHEdYUk3qtCxXMIF3SHoBU80SRR/9
	CLwls7ex+N8ZdAS+jIrstRGXM3OCSeCbL91RhyLUb4MWrXwVp0PnAb+rdE6HkL2fowOp
	U4jELwcnJffha5sZDfSyW0wh7N+GloX9vN1YvViPTpp0pH2776i0QfZ3GSyZU5r6gSAx
	7BDPF375eJytN14zbuFtqpVaIA/Wn3Cxou2kfDSkY1ijiiy5cL4cBmbH6lcqbMs/ZQ+3
	lNqpTCeYTym9uBqvxo32604dyfRzwXNo/4SCpTHL8sLil2bbvMccq3t6gaq7rJ3v7eOi
	aVZA==
X-Received: by 10.50.137.99 with SMTP id qh3mr36896508igb.7.1421864537959;
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
Received: from [192.168.141.85] ([66.49.180.141])
	by mx.google.com with ESMTPSA id kt1sm6424143igb.20.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
Message-ID: <54BFEE55.5040402@gmail.com>
Date: Wed, 21 Jan 2015 13:22:13 -0500
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: Ross Burton <ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
References: <1421849618-28332-1-git-send-email-ross.burton@intel.com>
In-Reply-To: <1421849618-28332-1-git-send-email-ross.burton@intel.com>
Subject: Re: [PATCH] bitbake: only check that /dev/shm is writable on Linux
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:17 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


On 01/21/15 09:13, Ross Burton wrote:
> -# Python multiprocessing requires /dev/shm
> -if not os.access('/dev/shm', os.W_OK | os.X_OK):
> +# Python multiprocessing requires /dev/shm on Linux
> +if sys.platform.startswith('linux') and not os.access('/dev/shm', os.W_OK | os.X_OK):

Cool! On what other platforms does bitbake work?

