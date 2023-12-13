Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3933C4167B
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 16:01:53 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.39547.1702483309643291412
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 08:01:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ccymKqDT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9FAA99C2CAF;
	Wed, 13 Dec 2023 11:01:48 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0CHVn3PzJLjL; Wed, 13 Dec 2023 11:01:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 52B1C9C3310;
	Wed, 13 Dec 2023 11:01:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 52B1C9C3310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702483308; bh=LJrODYCLZlpELfJR7tkHN933WwoNQwoWBpIRU2TWsAw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ccymKqDTMqL7uN2j6wLIaGCEdVIONyA05klUEm9WmFFJKxsrKCT5QicHQZFPI2K0E
	 ACQ2zkE23Zd8KNrlmAYatd4pJkej96Rg6p+1bxOzrkyAgs3smBGEi8YTXbx4HxgoYO
	 oa6m97vk1/es+Z5llkiMjFegR8IYSyurkQBMbLIoPqjbk1JqoRGqt/XOuatwjwGhg4
	 lUN0cxzisMDg+gA5gerkhkktSPAncv5bZtaZFj8gOC1ezQnzWHIjPFBL9EQ3chEw3/
	 QNqosSN/FasU4G010rvuVUttkgafxv9uvtE/bLtVME45yq62isD59ftYxLl6xLUtYI
	 iI9DTM/+sRy6g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id osZ68Vuc0uaa; Wed, 13 Dec 2023 11:01:48 -0500 (EST)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 329679C2C84;
	Wed, 13 Dec 2023 11:01:48 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCHv2 0/1] toaster: Added dataTables library to include sorting and pagination for table element
Date: Wed, 13 Dec 2023 11:01:40 -0500
Message-Id: <20231213160141.249276-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 16:01:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15664


Added dataTables library to include sorting and pagination for table elem=
ent
V2: Updated library jquery.Datatable to latest version 1.13.8 to fix miss=
ing icons and added default value to show 50 entries per page


