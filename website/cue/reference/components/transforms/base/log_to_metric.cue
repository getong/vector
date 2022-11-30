package metadata

base: components: transforms: log_to_metric: configuration: metrics: {
	description: "A list of metrics to generate."
	required:    true
	type: array: items: type: object: options: {
		field: {
			description: "Name of the field in the event to generate the metric."
			required:    true
			type: string: syntax: "template"
		}
		increment_by_value: {
			description:   "Increments the counter by the value in `field`, instead of only by `1`."
			relevant_when: "type = \"counter\""
			required:      false
			type: bool: default: false
		}
		kind: {
			description: """
				Metric kind.

				Metrics can be either absolute of incremental. Absolute metrics represent a sort of "last write wins" scenario,
				where the latest absolute value seen is meant to be the actual metric value.  In constrast, and perhaps intuitively,
				incremental metrics are meant to be additive, such that we don't know what total value of the metric is, but we know
				that we'll be adding or subtracting the given value from it.

				Generally speaking, most metrics storage systems deal with incremental updates. A notable exception is Prometheus,
				which deals with, and expects, absolute values from clients.
				"""
			relevant_when: "type = \"counter\""
			required:      false
			type: string: {
				default: "incremental"
				enum: {
					absolute:    "Absolute metric."
					incremental: "Incremental metric."
				}
			}
		}
		name: {
			description: """
				Overrides the name of the counter.

				If not specified, `field` is used as the name of the metric.
				"""
			required: false
			type: string: {
				default: null
				syntax:  "template"
			}
		}
		namespace: {
			description: "Sets the namespace for the metric."
			required:    false
			type: string: {
				default: null
				syntax:  "template"
			}
		}
		tags: {
			description: "Tags to apply to the metric."
			required:    false
			type: object: options: "*": {
				description: """
					A templated field.

					In many cases, components can be configured in such a way where some portion of the component's functionality can be
					customized on a per-event basis. An example of this might be a sink that writes events to a file, where we want to
					provide the flexibility to specify which file an event should go to by using an event field itself as part of the
					input to the filename we use.

					By using `Template`, users can specify either fixed strings or "templated" strings, which use a common syntax to
					refer to fields in an event that will serve as the input data when rendering the template.  While a fixed string may
					look something like `my-file.log`, a template string could look something like `my-file-{{key}}.log`, and the `key`
					field of the event being processed would serve as the value when rendering the template into a string.
					"""
				required: true
				type: string: syntax: "template"
			}
		}
		type: {
			required: true
			type: string: enum: {
				counter:   "A counter."
				gauge:     "A gauge."
				histogram: "A histogram."
				set:       "A set."
				summary:   "A summary."
			}
		}
	}
}
