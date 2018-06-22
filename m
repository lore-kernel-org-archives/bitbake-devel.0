Return-Path: <furkantokac34@gmail.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail.openembedded.org (Postfix) with ESMTP id 3E629786B5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2018 11:07:48 +0000 (UTC)
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so6300118wrk.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2018 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=lbGL/eciomS1D/FqufZQPpzlGiHBVEZ4MIv4eRSEARo=;
	b=qrvqnNzAh3S6GhGJ23zVpPG0WJospvbQaSziNBImPExd5OwF7DK9mthOIB6pz5n6F1
	55MH7tokmMwz/dPW0QzSXhHBt80iaUOI/sVgvupqWnd57Itbfmyi6i+1S3bDYRKbZ5zO
	9CBdyvcw4sykU86dOO0kqASa60jhfLHCR2xfz3FwesTn6b38GFFlW3eHai8bzTu2tcQ/
	ZOHM6N2mwPEjTHDKLDpVggWbtAj2ydUmMv6mEflESHwTDXV9kOi+pJCk/bANQ+Sw0Hit
	YEXSdFtfZprHVoAQWCz9NyrozHoeEI9GwKJxTWIR+miVIFTdu6NGfJaHcbxrk3dLV3Eh
	eseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=lbGL/eciomS1D/FqufZQPpzlGiHBVEZ4MIv4eRSEARo=;
	b=D7yxfAls/fe2Ov9i2d8xr+kMPo/yvKoDhtbrVSJSjJIudJYY8IqOpRESLzO/fEGTww
	cyqgvkA/XYBCNLKUenLUiIWzn6jOohGnat7PM6YttGO0tQd4/lcaX/ARwaO5g+54209d
	h5vdVgduXhTkh3fBfnja2VyYzC8WP6zzKDkWmeQphR3linoCFhYIqOGAvLvqiLwTHRh5
	FiU8AxU948x4qnU4lhRXX2T4yeeaC6hAQ43rIkgEP4DPKKYLdjzzV2sv7HNYWUSmLPG9
	dbmOcN5s8gO26qLNYkbFRRNuN0BGE2FjP1NpE+4XXVxmsuesSa15MCKYT2cI/HSgTYzN
	YVAQ==
X-Gm-Message-State: APt69E1VjVEsB57q06/tGSSnwBp1YZDEDOXbpptoWN8OPywgcla86Qct
	qCOBdzWp4bR4fE+diVzhpkp5FgNc
X-Google-Smtp-Source: AAOMgpcETg6OdAnQqRNxM2D19uEl7UTSGNdpCLOkleO/zos7LrFS1n0YmG578oPwXruH0TGT7kKk3A==
X-Received: by 2002:adf:8854:: with SMTP id
	e20-v6mr1310583wre.30.1529665668801; 
	Fri, 22 Jun 2018 04:07:48 -0700 (PDT)
Received: from [10.69.3.47] ([212.175.35.16]) by smtp.gmail.com with ESMTPSA id
	l67-v6sm1806194wmb.22.2018.06.22.04.07.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Jun 2018 04:07:48 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <20180621065936.31333-1-nicolac76@yahoo.fr>
	<89f00166-e4d7-c942-e475-31423e54c9e0@yahoo.fr>
From: Furkan Tokac <furkantokac34@gmail.com>
Message-ID: <fb369254-81a7-db2c-e497-f8b37581678f@gmail.com>
Date: Fri, 22 Jun 2018 14:07:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <89f00166-e4d7-c942-e475-31423e54c9e0@yahoo.fr>
Subject: Re: [PATCH] python: fix gcc 8 alignement error.
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
X-List-Received-Date: Fri, 22 Jun 2018 11:07:48 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

We're human beings, we do mistakes :)

On 6/21/18 10:11 AM, Nicolas Cornu via bitbake-devel wrote:
> Ignore this thread please. It's a terrible mistake from me.

