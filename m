Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219DCD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47895.1781890846380298022
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AMbPMIgI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvaZ3160141;
	Fri, 19 Jun 2026 10:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ItBhbGWUG
	2XSC/9D9jlJSKUR6nICsh2WnglytUTxLx8=; b=AMbPMIgIMLVv5bkIlAoxmpHPz
	L/7U/LllyxAZ6LXhQxbfkXyC1zkDbu12ejauuFcmo3S/28UX2YfOyPUR8Sgb8TIp
	7+9plsFGTw4rwcxsa17bmXRrOJmedRz1OD8ipas+IlVMH6/t6oUj+FDSRbPO0XZu
	mg9VR/8cnO7KTwtRXXvN5pNHZIPUQ/FYWb468VPgQWLPBQSHfU6nVEFVi1o2ds0F
	+bpU27bHe3aef54H8bHIxnmQ2YyS1r7y5pgSLBYI6ywFkr0oaYOQ0lE8k2uQC3kf
	SNOX7qGzi38L0H8Ct41/5Q9cESClTnFKEC+fiy45SqyYsqi/kgXS+41qy8bOQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:45 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Subject: [PATCH v4 0/9] bitbake-setup JSON Schema: Fix linting errors
Date: Fri, 19 Jun 2026 10:39:26 -0700
Message-ID: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9+NWoC/yXM3wpAMBSA8VfRubaaYTWvIhfbHBzlTztIybsbL
 n/19V3AGAgZquSCgAcxLXNEkSbgBzv3KKiNBiWVljozwhWC/YCTFaVxOldGyQ41xH4N2NH5ver
 mN+9uRL+9A7jvB4QMTLdtAAAA
X-Change-ID: 20260619-b4-schema-59b632920fe6
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 8uPQC0hZpJ4aIn2ApuKFPVXRKIjT5Id9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX5by57oQkauj+
 OH8Pv13T0TquD6YmeERfAQ/CIn97wc9CLuuciV+UavvotR1XVtPWGxlKeoNQu76Y6/PIxw7+o8/
 OXzvk4Rmc/ShZS+uHryUYWngG+ccZa61oSXuHUdqddH3vrxxQk4TgxuBd9AFRlvLpmf+Kp8Zzik
 d10bHxzBOG2ug/spwhXTIs0DX4yPJBSrk+WezrtsrwHWmUUsZbOmusQvM82N49pOWOXbU6lS6uI
 LDlqiRrQGvg5tTsP8EywG3t4PQlsmSSd+MAYIY+x8joaPdSvNtGzvyUUbwzcrnIuOfOzE57ttDs
 fBDUyCK9iGa/rlYlq8pKu6kTTYQEqteD4R8IaBSgtu05jpEUFZ51iJxz1H9ClQSjdb1GZXgGcYp
 NHOLrKKUicnO+16VQZKxs3E8S2Vbj3KTSyzdbI3zjHUjIVCviKc4/7Dqgf5fiRG7BkCFTdXz0dM
 /GSgpBwjN5ubfDJ4z5Q==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1d cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=iTjcBdDkjFE6-rxjVPEA:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 8uPQC0hZpJ4aIn2ApuKFPVXRKIjT5Id9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX+/YfH3c1wTUk
 mh4NrqEjVIhAcbp+LXIBymD6CH+l7U94aZT6ZyhG4xeAU4uTUVsvhGRewnQAF7Z2paPChS3hCHY
 dzXIf/+GKMW2X0izrQBjFCAuY6HN+dcTF/P/4NywBsvm6IEsunn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190167
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 17:40:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19752

UPDATES v4:
* bitbake-setup.schema.json: Add examples property
  * Updated commit message to match example

* bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas
  * Merged anyOf commits into one

layers.schema.json: Add examples property
* Moved version element to the end of the block
* Converted the git-remote elements to short form

UPDATES v3:
* bitbake-setup.schema.json
  * Updated example to bitbake+openembedded-core with qemux86-64+nodistro
* layers.schema.json
  * Fixed typo in description
  * Fixed up the title and description
  * Put the version element at the end
  * Used the short form

UPDATES v2:
  The following updates were made to v2 of this series:
   * Include an additional patch fixing an existing typo
   * Update the examples property to wrap it in an array and
     add a required configuration element

This series fixes some linting errors in the JSON Schema.  Problems
were found using the https://github.com/sourcemeta/jsonschema tool.

Here are the steps used to install and use the tool to lint the schemas:

```
  python3 -m venv venv
  source venv/bin/activate
  pip install sourcemeta-jsonschema
```

```
jsonschema lint setup-schema/bitbake-setup.schema.json
jsonschema lint setup-schema/layers.schema.json
```

NOTE: The examples are annotations and are meant for humans reading the schema.
They do not typically get checked automatically by the JSON Schema validation
tools.  Use jq to extract the JSON object into its own file to check it
separately.

```
cd setup-schema

jq .examples[] bitbake-setup.schema.json  > bitbake-setup.schema-examples.json
jsonschema validate bitbake-setup.schema.json bitbake-setup.schema-examples.json

jq .examples[] layers.schema.json  > layers.schema-examples.conf.json
jsonschema validate layers.schema.json layers.schema-examples.conf.json
cd ..

bitbake/bin/bitbake-setup init bitbake/setup-schema/bitbake-setup.schema-examples.conf.json

```

```
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/oe-nodistro-whinlatter.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-master.conf.json
jsonschema validate setup-schema/bitbake-setup.schema.json default-registry/configurations/poky-whinlatter.conf.json
```

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

UPDATE v2: Additional testing was performed with oe-selftest.  This uses
    python3-jsonschema which is a different implementation and caught
    additional linting errors.

UPDATE v3: Tested with bitbake-selftest, oe-selftest, and bitbake quilt-native

```
    git clone https://git.openembedded.org/bitbake

    ./bitbake/bin/bitbake-setup init --non-interactive poky-master poky machine/qemux86-64 distro/poky

    . /ala-lpggp31/rwoolley/oe-selftest-testing/bitbake-builds/poky-master/build/init-build-env

    echo 'SANITY_TESTED_DISTROS = ""' >> conf/local.conf

    oe-selftest -r bblayers.BitbakeLayers
```

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
Rob Woolley (9):
      bitbake-setup.schema.json: Add title for schema
      bitbake-setup.schema.json: Add examples property
      bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas
      bitbake-setup.schema.json: Remove trailing period
      layers.schema.json: Add missing schema
      layers.schema.json: Add title for subschema
      layers.schema.json: Add examples property
      layers.schema.json: Remove trailing period
      layers.schema.json: Fix typo in property name

 setup-schema/bitbake-setup.schema.json | 40 +++++++++++++++++++++++++++++++---
 setup-schema/layers.schema.json        | 24 ++++++++++++++++----
 2 files changed, 57 insertions(+), 7 deletions(-)
---
base-commit: 733161c76bd2ac777555d3eac113ff54b4c63ae2
change-id: 20260619-b4-schema-59b632920fe6

Best regards,
--  
Rob Woolley <rob.woolley@windriver.com>


