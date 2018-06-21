Return-Path: <nicolac76@yahoo.fr>
Received: from sonic307-54.consmr.mail.ir2.yahoo.com
	(sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	by mail.openembedded.org (Postfix) with ESMTP id A228178748
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2018 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
	t=1529565110; bh=B63t070Y+W6a4/S6W0J7LoypOOPXKsgbj+vU76PYelM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From:Subject;
	b=HKpgSvLrHIcxquxyT5U1OrinHxVltg9Grw3wVPlkh5Zrrey0A5OZ3xey+Stts9WLNMFbx5rYWqZJBL7E5oiugdX/UBg40xAF8dtuE59uVLb93TCgpvkRBmLiHE8nhu64tf7vnWOiylugUNLLohyDUgW+DHFbr/emzSwE8LefTgd4swFGvTBzN0VcVp9XKtJ/sA/ArPXdGTZxlUaZqrEqBSsxstkF9x7+a0PTul9y8W23djKO9DFStyvI3HeqxQiQbt0ty7UW4Bwj8T2gEBX8sJVDWik1rhNPa0N+tXD2/URldVDmR5Uwpr3zwAfIHLg6lA2Y9VQb2iog8le3Eg3z2A==
X-YMail-OSG: 7epod3MVM1kITT4yCb3UWSlSlMaLH8xZsH0I.pFLyLj7Tjrula_RDLYcZcWipRT
	gUAylHgeonBOwCTD4yR8X_4ERRycghK.ZsiqnyHV.ogDugA58PSj5TJsdTc09alFpkeXuqKMKA.X
	aSlpA.DDZqpy0ZxVS1hk2OuC6TMuH2QHgXKYx_AURSucCNK_QY.FFTiWO0M6PNFwRiWb6yeZKt8K
	m8tHmrNAoXOsxTs40ofPPQ8NV_ilrAVBn7eL.BYk1GzvpLQgluSoa922FxgPx4LDvqZPOSeDGc7M
	yxnL1B7lgF3fXDhZHVJNa.CVh8peuuQYhPpkfkoQDFsnaHE8slXpVijLzz4omwErclKHfG6uP5ho
	qb1A5.ItlLw.kG5DwTMBwkLokyo55cDvUViXAHIkBte2rug44dv8AdvZdjnULzvn0RyZJlv5sHu4
	iREKRQ7oinBBDY10UYd5.hwJRm5I95kkfV9xmysvGXQqjfQaGVEi75Fgz2bIrbsFU95mxS7ACtmH
	H7ojlZUnSBwZvifRzrekFErr2AqsLr4lLsXFPdGYIO1CIiOpFYraRb0oFCb5.RjDJ.Urckh20dVK
	QYGaAJErCahXmHvWwlpdp7RvbIox3LRdMd7OO10tZSMBAgA5EjP2GTeZxa4QwoGK2dCLUkagO194
	qoKccJmbgRAQkltz5jCcnhVNCW1XF6ttGO01_LaDpHcgIR.lidYh0HLzyF9iW4irnEAMX6qoTOAt
	9Q8k06wpzmI7QUEFIivQvIbU8dPLV_O1nXKbOdSDGNHuFVsgOrhn0aG3995eGtFvK1OEctCmj6yo
	LtZfe90XHEaLx85rtmBJdzN5hJ3g0Fu6CwThpdUCv9qkPxe5BoIhn4nRw0BXKzzEpFZ9WGu4vD_D
	Itr0zZIZoUs4PV.s5GXCkhygBtpnyR_a.T4O1vmrWLF6wRLWfmrMT6uDnJtQLKRH5sFOyDa9_lKI
	-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic307.consmr.mail.ir2.yahoo.com with HTTP;
	Thu, 21 Jun 2018 07:11:50 +0000
Received: from 80.245.18.66 (EHLO Achlys.localdomain) ([80.245.18.66])
	by smtp412.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	17f812cc18c7e114c5be8587c1de436b; 
	Thu, 21 Jun 2018 07:11:47 +0000 (UTC)
From: Nicolas Cornu <nicolac76@yahoo.fr>
To: Nicolas Cornu <nicolac76@yahoo.fr>
References: <20180621065936.31333-1-nicolac76@yahoo.fr>
Message-ID: <89f00166-e4d7-c942-e475-31423e54c9e0@yahoo.fr>
Date: Thu, 21 Jun 2018 09:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Firefox/52.0 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621065936.31333-1-nicolac76@yahoo.fr>
Cc: Vivien Henriet <v.henriet@overkiz.com>,
	bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 21 Jun 2018 07:11:50 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ignore this thread please. It's a terrible mistake from me.

