Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412AF46C6F
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:21:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60246.1775496071599085030
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 10:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cjU1u398;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85563bbf72=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636ASbBp1474696
	for <bitbake-devel@lists.openembedded.org>; Mon, 6 Apr 2026 10:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=6xl0bZjsJ04qMqe+PryQ
	VOE/mB2pUTDBxuy5SUYpOWk=; b=cjU1u398MrDgqM6zQsjH4T2TDy8WZnoKK9ei
	i96xMh23TgOJhMYE+doV4lobOQkNHqrTMS2yQzc4VmWMNtnVPyrplEgCnUBS5WnN
	MSjxQGrkTWxphVihUUsIk5roYnMWLA00dSWd8h8c+3kNb4LwMhspysum0W0pcLfq
	kQtLqmzbhNMSrxEot/catbzPYvL10Iu8LHcjUPQvDL3q1sR50uNbebhFowe196LM
	poUPoO4jl1AKdqhVAmxUub+UoBog6Az5skIyc/zfZ4cj6yM3bUFXeFZtVz8+jGC3
	C8mbe8befimzmOLgWgZpiC9JxgmkQdTxrDnWJ+/9RulZnVF67g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dawwx9rha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 10:21:11 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Apr 2026 10:21:10 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Apr 2026 10:21:10 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/8] bitbake-setup JSON Schema: Fix linting errors
Date: Mon, 6 Apr 2026 10:21:02 -0700
Message-ID: <20260406172110.2050236-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3MCBTYWx0ZWRfXxrB7HTVRFijl
 EMUBzyns+1UkARPQTlZ/kTmskvgWge46XcVwnlcjVu4DdNzhKebVc/DgzbY2TcC5KynkVDvd7uW
 E3vlV9kzksIkL5m8okPtPAzp0Ek4HBoXsA95CsAhOA2Y+g8c7FfjzzDv4NWMrdCjqoLGPldssCc
 bjmbvzqSQASgSRfFJyCEao4C3GMsNy4paqabzGcmKPFt4HASWy0lmxysyCv6ZycU9L1XMNkhfyn
 Cll9pwbuoZaLMEs40671n6vXmqF3kcBhB4uOZy1iI4vq82zbkcsIUDpPQud+bRg1JX8kXjrkaKh
 cgKGUkWqt/xuZCqLp0FUTjmgVW0mj5Zm9cYuxDQ0R5XllXGuVU/jMlt+SAoHub5lcPlxARvUV8w
 6G4QJPy2IX606eCYAZ3xcu7TYsVzltzVH4KuvTc5NqpW0QBdNYR5NkhI1Ot/0ElC03jGgUO9mYw
 V60kJP3dESAss/FZ4Fw==
X-Proofpoint-ORIG-GUID: 0ILriwb5GhOv8uqEgx8SO-3OeDbf5Mg2
X-Proofpoint-GUID: 0ILriwb5GhOv8uqEgx8SO-3OeDbf5Mg2
X-Authority-Analysis: v=2.4 cv=AZm83nXG c=1 sm=1 tr=0 ts=69d3eb87 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8 a=D1D_9dX_knVvMLLzGboA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060170
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 17:21:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19324

This series fixes some linting errors in the JSON Schema.  Problems
were found using the https://github.com/sourcemeta/jsonschema tool.

Here are the steps used to install and use the tool to lint the schemas:

  python3 -m venv venv
  source venv/bin/activate
  pip install sourcemeta-jsonschema
  jsonschema lint bitbake-setup.schema.json
  jsonschema lint layers.schema.json

This allowed me to use jsonschema to validate the BitBake Configuration File:
  jsonschema validate path/to/bitbake-setup.schema.json oe-nodistro-master.conf.json

There are 2 outstanding types of linting errors related to the use of hyphen
in the property names and the enum currently having only one value:

  Set `properties` to identifier names that can be easily mapped to programming
  languages (matching [A-Za-z_][A-Za-z0-9_]*) (simple_properties_identifiers).

  An `enum` of a single value can be expressed as `const` (enum_to_const)

The former would require a larger discussion and potentially increasing the
version number. Updating the enum to include a new version would also resolve
the latter error.

I do not believe that the changes in this series merit increasing the version
of the schema.

Resolving these outstanding errors is not necessary for validating the
Bitbake Configuration files.

