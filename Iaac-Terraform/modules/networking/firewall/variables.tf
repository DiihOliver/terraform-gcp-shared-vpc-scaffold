/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
variable "network" {
  description = "The name or self_link of the network to attach this firewall to."
}

variable "name" {
  description = "Name of the resource."
}

variable "disabled" {
  description = "Name of the resource."
  type        = bool
  default     = false
}

variable "protocol" {
  description = "The IP protocol to which this rule applies."
}

variable "ports" {
  description = "An optional list of ports to which this rule applies."
}

variable "source_ranges" {
  description = "A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]."
}

variable "source_tags" {
  description = "If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags."
}

variable "target_tags" {
  description = "A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed[]. "
}
